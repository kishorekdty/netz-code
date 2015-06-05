
import simplejson
import ast
from datetime import datetime

from django.core.urlresolvers import reverse
from django.views.generic.base import View
from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect

from exam.models import *
from academic.models import Student


class ScheduleExam(View):
    def get(self, request, *args, **kwargs):
        course = request.GET.get('course', '')
        if course :
            exams = Exam.objects.filter(course__id=course)
        else:
            exams = Exam.objects.all()
        if request.is_ajax():
            exam_list = []
            for exam in exams:
                exam_list.append({
                    'id': exam.id,
                    'name': exam.exam_name,
                    'course': exam.course.course,
                    'semester': exam.semester.semester,
                    'start_date': exam.start_date.strftime('%d/%m/%Y') if exam.start_date else '',
                    'end_date': exam.end_date.strftime('%d/%m/%Y') if exam.end_date else '',
                })
            res = {
                'result': 'Ok',
                'exams':  exam_list
            }
            status_code = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")

        ctx = {
            'exams': exams
        }
        return render(request, 'list_exam_schedule.html',ctx)

class CreateExam(View):
    def get(self, request, *args, **kwargs):
        return render(request, 'add_exam_schedule_details.html',{})


class CreateQuestion(View):
    def get(self, request, *args, **kwargs):             
        return render(request, 'create_questions.html', {})

class SaveQuestions(View):
    def post(self, request, *args, **kwargs):
        questions = ast.literal_eval(request.POST['question_details'])
        course = Course.objects.get(id = questions['course'])
        semester = Semester.objects.get(id = questions['semester'])
        exam = Exam.objects.get(id = questions['exam'])
        subject_details = questions['subject']
        subject = Subject.objects.get(id = subject_details['subject_id'])
        total_mark = 0
        if request.is_ajax(): 
            # try:
            for question_detail in questions['questions']:
                question = Question.objects.create(exam=exam,subject=subject)
                question_data = question.set_attributes(question_detail)
            res = {
                'result': 'ok',
            } 
            # except:
            #     res = {
            #             'result': 'error',
            #         } 
            status_code = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")
        return render(request, 'create_questions.html', {})


def save_exam_schedule_details(exam, request):
    print("wwwww")
    exam.start_date = datetime.strptime(request.POST['start_date'], '%d/%m/%Y')
    exam.end_date = datetime.strptime(request.POST['end_date'], '%d/%m/%Y')
    course = Course.objects.get(id = request.POST['course'])
    semester = Semester.objects.get(id = request.POST['semester'])
    print(exam.start_date,exam.end_date,course,semester)
    if request.POST['student']:
        print("mmm")
        student = Student.objects.get(id=request.POST['student'])
        exam.student = student
    exam.exam_name = course.course + '-' +semester.semester
    exam.no_subjects = request.POST['no_subjects']
    exam.exam_total = request.POST['exam_total']
    subjects = ast.literal_eval(request.POST['subjects'])
    exam.save()
    for subject in subjects:
        print(subject)        
        sub, created = Subject.objects.get_or_create(subject_name=subject['subject_name'])
        sub.duration = subject['duration']
        sub.duration_parameter = subject['duration_parameter']
        sub.total_mark = subject['total_mark']
        sub.pass_mark = subject['pass_mark']
        sub.save()
        exam.subjects.add(sub)
    exam.save()

class SaveExamSchedule(View):
    def post(self, request, *args, **kwargs):
        if request.is_ajax():
            try:
                student = Student.objects.get(id=request.POST['student'])
            except:
                print "Exception"
                student = ''
            print student,"student"
            try:
                course = Course.objects.get(id = request.POST['course'])
                semester = Semester.objects.get(id = request.POST['semester'])
                exam_name = ''
                exam_name = course.course + '-' +semester.semester
                if student:
                    exam = Exam.objects.get(course=course,semester=semester,exam_name=exam_name,student=student)
                else:
                    exam = Exam.objects.get(course=course,semester=semester,exam_name=exam_name)
                print exam,"exam"
                res = {
                    'result': 'error',
                    'message': 'Exams Scheduled Already'
                }
                status_code = 200
            except Exception as ex:
                print str(ex), "Exception ===="
                exam_name = ''
                exam_name = course.course + '-' +semester.semester
                if student:
                    exam = Exam.objects.create(course=course,semester=semester,exam_name=exam_name)
                else:
                    exam = Exam.objects.create(course=course,semester=semester,exam_name=exam_name)
                print exam
                save_exam_schedule_details(exam, request)                     
                res = {
                    'result': 'Ok',
                }
                status_code = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")

class ViewExamSchedule(View):

    def get(self, request, *args, **kwargs):
        exam_schedule_id = kwargs['exam_schedule_id']
        if request.is_ajax():
            try:
                exam = Exam.objects.get(id = exam_schedule_id)
                exam_schedule = exam.get_json_data()
                res = {
                    'result': 'ok',
                    'exam_schedule': exam_schedule,
                }
                status = 200
            except Exception as ex:
                print "Exception == ", str(ex)
                res = {
                    'result': 'error',
                    'exam_schedule': str(ex),
                }
                status = 500
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

class GetExams(View):

    def get(self, request, *args, **kwargs):
        
        course_id = kwargs['course_id']
        semester_id = kwargs['semester_id']
        exams = {}
        if request.is_ajax():
            try:
                exam = Exam.objects.get(course=course_id, semester=semester_id,student__user=request.user)
                exams = exam.get_json_data()
                if request.GET.get('from', '') == 'write_exam':
                    exams = exam.get_json_data('x')
                else:
                    exams = exam.get_json_data()
            except:
                try:
                    exam = Exam.objects.get(course=course_id, semester=semester_id,student=None)
                    if request.GET.get('from', '') == 'write_exam':
                        exams = exam.get_json_data('x')
                    else:
                        exams = exam.get_json_data()
                except:
                    res = {
                        'result': 'error',
                        'message': 'No exams Scheduled',
                    }
                # for exam in exams:
            if exams:    
                try:
                    student = Student.objects.get(user=request.user)
                    exams.update({
                        'student_name':student.student_name,
                        'registration_no':student.registration_no,
                        'hall_ticket_no':student.hall_ticket_no,
                        }) 
                except:
                    pass 
                print exams
                res = {
                    'result': 'ok',
                    'exams': exams,
                }       
    
            # except Exception as ex:
            #     print "Exception == ", str(ex),
            #     res = {
            #         'result': 'error',
            #         'message': str(ex),
            #     }
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')

class GetExamCreate(View):
    def get(self, request, *args, **kwargs):
        
        course_id = kwargs['course_id']
        semester_id = kwargs['semester_id']
        print(course_id,semester_id)
        if request.is_ajax():
            try:
                print("rrr")
                exam = Exam.objects.get(course=course_id, semester=semester_id)
                question_number = Question.objects.filter(exam=exam).count()
                exams = exam.get_json_data()
                print(exams)
                res = {
                'result': 'ok',
                'exams': exams,
                'question_number':question_number,
                } 
            except:
                res = {
                'result': 'error',
                
                }
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')     

class DeleteExamSchedule(View):
    def get(self, request, *args, **kwargs):

        exam_schedule_id = kwargs['exam_schedule_id']       
        exam = Exam.objects.filter(id=exam_schedule_id)                          
        exam.delete()
        return HttpResponseRedirect(reverse('schedule_exam'))

class EditExamSchedule(View):

    def get(self, request, *args, **kwargs):
        
        exam_schedule_id = kwargs['exam_schedule_id']
        return render(request, 'edit_exam_schedule.html', {
            'exam_schedule_id': exam_schedule_id
        })

    def post(self, request, *args, **kwargs):
        if request.is_ajax():
            current_date = datetime.now().date()
            # exam =  ast.literal_eval(request.POST['exam_schedule'])
            # print("qeqwe")
            exam_schedule_id = kwargs['exam_schedule_id']
            exam = Exam.objects.get(id=exam_schedule_id)
            # exam.subjects = []
            # exam.save()
            print(exam,exam.start_date > current_date)
            if exam.start_date > current_date: 
                print("eee")   
                save_exam_schedule_details(exam, request)
                res = {
                    'result': 'Ok',
                }
            else:
                print("xxx")
                print(exam)
                res = {
                    'result': 'error',
                    'message': 'You cannot edit exam schedule, as the exam is scheduled today',
                }
            
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')
        return render(request, 'edit_exam_schedule.html', {
            'exam_schedule_id': exam_schedule_id
        })

class GetSubjects(View):

    def get(self, request, *args, **kwargs):
        subject_list = []
        if request.is_ajax():
            subjects = Subject.objects.all()
            for subject in subjects:
                subject_list.append(subject.get_json_data())
            res = {
                'result': 'Ok',
                'subjects': subject_list,
            }
        response = simplejson.dumps(res)
        return HttpResponse(response, mimetype='application/json')

class ListQuestions(View):
    def get(self, request, *args, **kwargs):
        if request.is_ajax():
            try:
                questions_list = []
                questions = Question.objects.filter(subject=request.GET.get('subject', ''))
                
                for question in questions:
                    questions_list.append(question.get_json_data())
                res = {
                    'result': 'Ok',
                    'questions': questions_list,
                }
            except:
                res = {
                'result': 'error',
                'message': 'No questions found for this subject'
                }
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')
        return render(request, 'list_questions.html', {})


class QuestionPaper(View):

    def get(self, request, *args, **kwargs):
        questions_list = []
        if request.is_ajax():
            current_date = datetime.now().date()
               
            exam = Exam.objects.get(id=request.GET.get('exam', ''))
            print current_date,exam.start_date >= current_date and exam.end_date <= current_date,exam.start_date,exam.end_date
            if exam.start_date <= current_date and exam.end_date >= current_date:
                try:
                    
                    answer_sheet = AnswerSheet.objects.get(student__user=request.user, exam=request.GET.get('exam', ''), subject=request.GET.get('subject', ''))
                    res = {
                        'result': 'error',
                        'message': 'Already Wrote the exam'
                    }
                    
                except Exception as ex:
                    try:
                        questions = Question.objects.filter(exam=request.GET.get('exam', ''),subject=request.GET.get('subject', ''))
                        
                        for question in questions:
                            questions_list.append(question.get_json_data())
                        res = {
                            'result': 'Ok',
                            'questions': questions_list,
                        }
                    except:
                        res = {
                        'result': 'error',
                        'message': 'No questions found for this subject'
                        }
            else:
                res = {
                        'result': 'error',
                        'message': 'You are late to attempt this exam'
                    }

            response = simplejson.dumps(res)
        return HttpResponse(response, mimetype='application/json')

class CreateAnswerSheet(View):


    def post(self, request, *args, **kwargs):
        if request.is_ajax():
            answer_sheet_details =  ast.literal_eval(request.POST['answer_details'])
            try:
                exam = Exam.objects.get(id=answer_sheet_details['exam'])
                subject = Subject.objects.get(id=answer_sheet_details['subject'])
                student = Student.objects.get(user=request.user)
                answer_sheet = AnswerSheet.objects.create(student=student, exam=exam, subject=subject)
                
                answer_sheet.is_attempted = True;
                answer_sheet.save()
                res = {
                    'result': 'Ok',
                    'id': answer_sheet.id,
                }
            except Exception as ex:
                res = {
                    'result': 'error',
                    'message': str(ex),
                }
                
        response = simplejson.dumps(res)
        return HttpResponse(response, mimetype='application/json')

class EditQuestion(View):

    def get(self, request, *args, **kwargs):
        question_id = kwargs['question_id']
        print question_id
        if request.is_ajax():
            try:
                
                question = Question.objects.get(id=question_id)
                choices = []
                if question.choices:
                    if question.choices.all().count() > 0:
                        for choice in question.choices.all().order_by('id'):
                            choices.append({
                                'id': choice.id,
                                'choice': choice.choice,
                                'correct_answer': choice.correct_answer,
                            })  
                question = {
                    'question': question.question,
                    'id': question.id,
                    'mark': question.mark,
                    'choices':choices,
                }
                res = {
                    'result': 'Ok',
                    'question': question,
                }
            except Exception as ex:
                print str(ex)
                res = {
                'result': 'error',
                'message': 'No questions found for this subject'
                }
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')
        return render(request, 'edit_questions.html', {'question_id': question_id})
    
    def post(self, request, *args, **kwargs):
        if request.is_ajax():
            question_id = kwargs['question_id']
            # try:
            question_detail = ast.literal_eval(request.POST['question'])
            question = Question.objects.get(id=question_id)
            question.question = question_detail['question']
            question.mark = question_detail['mark']
            choices = question_detail['choices']
            for choice_data in choices:
                choice = Choice.objects.create(choice=choice_data['choice'])
                if choice_data['correct_answer'] == 'true':
                    choice.correct_answer = True
                else:
                    choice.correct_answer = False
                choice.save()
                question.choices.add(choice)
            question.save()
            res = {
                'result': 'ok',
            }
            # except:
            #     res = {
            #         'result': 'error',
            #     }
        response = simplejson.dumps(res)
        return HttpResponse(response, mimetype='application/json')

class DeleteQuestion(View):
    def get(self, request, *args, **kwargs):
        question_id = kwargs['question_id']       
        question = Question.objects.filter(id=question_id)                          
        question.delete()
        return HttpResponseRedirect(reverse('list_questions'))

class WriteExam(View):

    def get(self, request, *args, **kwargs):
        if request.is_ajax():
            try:
                student = Student.objects.get(user=request.user)
                student_details = student.get_json_data()
                res = {
                    'result': 'Ok',
                    'student': student_details,
                }
            except Exception as ex:
                res = {
                        'result': 'error',
                        'message': str(ex),
                    }
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')
        return render(request, 'write_exam.html', {})

    def post(self, request, *args, **kwargs):

        if request.is_ajax():
            answer_sheet_details =  ast.literal_eval(request.POST['answer_details'])
            print(answer_sheet_details)
            # try:
            answer_sheet = AnswerSheet.objects.get(id=answer_sheet_details['id'])
            answer_sheet_data = answer_sheet.set_attributes(answer_sheet_details)
            res = {
                'result': 'Ok',
            }
            # except Exception as ex:
            #     res = {
            #         'result': 'error',
            #         'message': str(ex),
            #     }
        response = simplejson.dumps(res)
        return HttpResponse(response, mimetype='application/json')