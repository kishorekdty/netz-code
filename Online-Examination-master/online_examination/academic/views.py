
import simplejson
import ast

from django.core.urlresolvers import reverse
from django.views.generic.base import View
from django.shortcuts import render
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseRedirect

from academic.models import Student
from datetime import datetime
import string
from random import sample, choice

from college.models import Course, Semester

class AddStudent(View):
    def get(self, request, *args, **kwargs):
        return render(request, 'add_student.html', {})
    def post(self, request, *args, **kwargs):
        if request.is_ajax():
            try:
                chars = string.letters + string.digits
                length = 8
                password = ''.join(choice(chars) for _ in xrange(length))
                print password
                course = Course.objects.get(id = request.POST['course'])
                # semester = Semester.objects.get(id=request.POST['semester'])
                student, created = Student.objects.get_or_create(course=course, student_name=request.POST['student_name'])
                if not created:
                    res = {
                        'result': 'error',
                        'message': 'Student  already existing'
                    }
                else:
                    try:
                        username = str(request.POST['registration_no']) + str(request.POST['hall_ticket_no'])
                        user = User.objects.create(email= request.POST['email'],username=username)
                        user.set_password(password)
                        user.save()
                        student.user = user
                        student.student_name = request.POST['student_name']
                        student.student_password = password
                        student.registration_no = request.POST['registration_no']
                        student.address = request.POST['address']
                        student.course = course
                        # student.semester = semester
                        student.father_name = request.POST['father_name']
                        student.pass_out_year = request.POST['pass_out_year']
                        student.specialization = request.POST['specialization']
                        student.age = request.POST['age']
                        student.source = request.POST['source_of_information']
                        student.hall_ticket_no = request.POST['hall_ticket_no']
                        student.dob = datetime.strptime(request.POST['dob'], '%d/%m/%Y')
                        student.address = request.POST['address']
                        student.mobile_number = request.POST['mobile_number']
                        student.email = request.POST['email']
                        student.photo = request.FILES.get('photo_img', '')  
                        student.permanent_address = request.POST['permanent_address']
                        student.guardian_mobile_number = request.POST['guardian_mobile_number'] 
                    except Exception as ex:
                        res = {
                            'result': 'error',
                            'message': str(ex)
                        }
                    student.save()
                    res = {
                        'result': 'ok',
                        'auto_genrated_password':password,
                    }                     
            except Exception as ex:
                res = {
                    'result': 'error',
                    'message': str(ex)
                }
            status_code = 200 
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")
        return render(request, 'list_student.html', {})

class ListStudent(View):
    def get(self, request, *args, **kwargs):
        if request.GET.get('course_id', ''):
            students = Student.objects.filter(course__id=request.GET.get('course_id', '')).order_by('registration_no')
        else:
            students = Student.objects.all().order_by('registration_no')   
        if request.is_ajax():
            student_list = []
            for student in students:
                student_list.append({
                    'id': student.id,
                    'name': student.student_name,
                    'roll_number': student.registration_no,
                })            
            response = simplejson.dumps({
                'result': 'Ok',
                'students': student_list
            })
            return HttpResponse(response, status = 200, mimetype="application/json")
        ctx = {
            'students': students
        }
        return render(request, 'list_student.html',ctx)



class GetStudent(View):

    def get(self, request, *args, **kwargs):
        course_id = kwargs['course_id']
        semester_id = kwargs['semester_id']
        if request.is_ajax():
            try:
                students = Student.objects.filter(course__id=course_id, semester__id=semester_id)
                student_list = []
                for student in students:
                    student_list.append({
                        'student': student.student_name,
                        'id' :student.id 
                    })
                res = {
                    'result': 'ok',
                    'students': student_list,
                }
            except Exception as ex:
                res = {
                    'result': 'error: '+ str(ex),
                }
            status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

class ViewStudentDetails(View):  

    def get(self, request, *args, **kwargs):
        
        student_id = kwargs['student_id']
        ctx_student_data = []
        if request.is_ajax():
            try:
                student = Student.objects.get(id = student_id)
                
                ctx_student_data.append({
                    'student_name': student.student_name if student.student_name else '',
                    'student_password':student.student_password if student.student_password else '',
                    'age': student.age if student.age else '',
                    'registration_no': student.registration_no if student.registration_no else '',
                    'hall_ticket_no': student.hall_ticket_no if student.hall_ticket_no else '',
                    'dob': student.dob.strftime('%d/%m/%Y') if student.dob else '',
                    'address': student.address if student.address else '',
                    'permanent_address': student.permanent_address if student.permanent_address else '',
                    'course': student.course.course if student.course.course else '',
                    'course_id': student.course.id if student.course.course else '',
                    # 'semester': student.semester.semester if student.semester.semester else '',
                    'specialization': student.specialization if student.specialization else '',
                    'pass_out_year': student.pass_out_year if student.pass_out_year else '',
                    'father_name': student.father_name if student.father_name else '',
                    # 'course_id': student.semester.id if student.semester.semester else '',
                    'mobile_number': student.mobile_number if student.mobile_number else '',
                    'email': student.email if student.email else '',
                    'photo': student.photo.name if student.photo.name else '',
                    'guardian_mobile_number': student.guardian_mobile_number if student.guardian_mobile_number else '',
                })
                res = {
                    'result': 'ok',
                    'student': ctx_student_data,
                }
            except Exception as ex:
                res = {
                    'result': 'error: ' + str(ex),
                    'student': ctx_student_data,
                }
            status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

class EditStudentDetails(View):
   
    def get(self, request, *args, **kwargs):
        
        student_id = kwargs['student_id']
        context = {
            'student_id': student_id,
        }
        ctx_student_data = []
        if request.is_ajax():
            try:
                course =  request.GET.get('course', '')
                # semester =  request.GET.get('semester', '')              

                if course:
                    course = Course.objects.get(id=course)
               
                # if semester:
                #     semester = Semester.objects.get(id=semester)
                student = Student.objects.get(id = student_id)

                

                ctx_student_data.append({
                    'student_name': student.student_name if student.student_name else '',
                    'age': student.age if student.age else '',
                    'source_of_information':student.source if student.source else '',
                    'registration_no': student.registration_no if student.registration_no else '',
                    'hall_ticket_no': student.hall_ticket_no if student.hall_ticket_no else '',
                    'dob': student.dob.strftime('%d/%m/%Y') if student.dob else '',
                    'address': student.address if student.address else '',
                    'photo': student.photo.name if student.photo.name else '',
                    'permanent_address': student.permanent_address if student.permanent_address else '',
                    'course': student.course.course if student.course.course else '',
                    'course_id': student.course.id if student.course.course else '',
                    # 'semester': student.semester.semester if student.semester.semester else '',
                    'pass_out_year': student.pass_out_year if student.pass_out_year else '', 
                    'specialization': student.specialization if student.specialization else '',
                    'father_name': student.father_name if student.father_name else '',
                    # 'course_id': student.semester.id if student.semester.semester else '',
                    'mobile_number': student.mobile_number if student.mobile_number else '',
                    'email': student.email if student.email else '',
                    'photo': student.photo.name if student.photo.name else '',
                    'guardian_mobile_number': student.guardian_mobile_number if student.guardian_mobile_number else '',
                })
                res = {
                    'result': 'ok',
                    'student': ctx_student_data,
                }
            except Exception as ex:
                res = {
                    'result': 'error: '+ str(ex),
                    'student': ctx_student_data,
                }
            status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')
        return render(request, 'edit_student_details.html',context)

    def post(self, request, *args, **kwargs):
        print "hi"
        student_id = kwargs['student_id']
        student = Student.objects.get(id = student_id)
        print student,"jsjs"
        student_data = ast.literal_eval(request.POST['student'])
        print student_data
        print request.FILES
        # try:
        course = Course.objects.get(id = student_data['course_id'])
        student.course=course
        # semester = Semester.objects.get(id = student_data['semester'])
        # student.semester=semester
        student.student_name = student_data['student_name']
        student.source = student_data['source_of_information']
        student.registration_no = student_data['registration_no']
        student.specialization = student_data['specialization']
        student.father_name = student_data['father_name']
        student.address = student_data['address']
        student.age = student_data['age']
        student.pass_out_year = student_data['pass_out_year']
        student.hall_ticket_no = student_data['hall_ticket_no']
        student.dob = datetime.strptime(student_data['dob'], '%d/%m/%Y')
        student.address = student_data['address']
        student.mobile_number = student_data['mobile_number']
        student.email = student_data['email']
        student.photo = request.FILES.get('photo', '')  
        student.permanent_address = student_data['permanent_address']
        student.guardian_mobile_number = student_data['guardian_mobile_number'] 

         
        student.save()
        res = {
            'result': 'ok',
        }
        status = 200
        # except Exception as Ex:
        #     res = {
        #         'result': 'error',
        #         'message': str(Ex)
        #     }
        #     status = 500
        response = simplejson.dumps(res)
        return HttpResponse(response, status=status, mimetype='application/json')

class DeleteStudentDetails(View):
    def get(self, request, *args, **kwargs):
        student_id = kwargs['student_id']       
        student = Student.objects.filter(id=student_id)                          
        student.delete()
        return HttpResponseRedirect(reverse('list_student'))