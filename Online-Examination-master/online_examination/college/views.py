import sys
import simplejson
import ast
from django.core.urlresolvers import reverse
from django.views.generic.base import View
from django.shortcuts import get_object_or_404, render
from django.http import Http404, HttpResponse, HttpResponseRedirect
from college.models import *
from academic.models import Student



class ListCourse(View):
    def get(self, request, *args, **kwargs):
        if request.user.is_superuser:
            courses = Course.objects.all()
        else:
            student = Student.objects.get(user=request.user)
            courses = Course.objects.filter(id=student.course.id)
        ctx = {
            'courses': courses
        }
        if request.is_ajax():
            course_list = []
            for course in courses:
                course_list.append({
                    'course': course.course, 
                    'id': course.id                
                })
            res = {
                'result': 'ok',
                'courses': course_list,
            }
            status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

        return render(request, 'course.html',ctx)

class ListSemester(View):
    def get(self, request, *args, **kwargs):

        
        if request.user.is_superuser:
            semesters = Semester.objects.all()
        else:
            student = Student.objects.get(user=request.user)
            semesters = Semester.objects.filter(id=student.semester.id)
        ctx_semester_data = []
        status = 200
        if request.is_ajax():
            for semester in semesters:
                ctx_semester_data.append({
                    'id': semester.id,
                    'semester': semester.semester,
                })
            res = {
                'result': 'ok',
                'semesters': ctx_semester_data,
            }
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')
        
        ctx = {
            'semesters': semesters
        }
        return render(request, 'semester.html',ctx)



class EditCourse(View):

    def get(self, request, *args, **kwargs):
        course_id = kwargs['course_id']
        context = {
            'course_id': course_id,
        }
        ctx_data = []
        semester_set = []
        if request.is_ajax():
            try:
                course = Course.objects.get(id = course_id)
                semester_list = course.semester.all()
                for semester in semester_list:
                    semester_set.append({
                        'semester_id': semester.id,
                        'semester_name': semester.semester,
                    })
                ctx_data.append({
                    'course': course.course,
                    'semester_details': semester_set,                                                        
                })
                res = {
                    'result': 'ok',
                    'course': ctx_data,
                }
                status = 200
            except Exception as ex:
                print "Exception == ", str(ex)
                res = {
                    'result': 'error: '+ str(ex),
                    'course': ctx_data,
                }
                status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

        return render(request, 'edit_course.html',context)

    def post(self, request, *args, **kwargs):

        course_id = kwargs['course_id']        
        course = Course.objects.get(id = course_id)
        data = ast.literal_eval(request.POST['course'])     
        semester_details = ast.literal_eval(request.POST['semester_list']) 
        try:
            course.course = data['course']
            course.save()
            semester_remove = course.semester.all();
            for semester_id in semester_remove:              
                course.semester.remove(semester_id)
            for semester_id in semester_details:               
                semester = Semester.objects.get(id = semester_id)              
                course.semester.add(semester)
            res = {
                'result': 'ok',
            }
            status = 200
        except Exception as Ex:
            print "Exception == ", str(Ex)
            res = {
                'result': 'error',
                'message': 'Course with this name is already existing'
            }
            status = 200
        response = simplejson.dumps(res)
        return HttpResponse(response, status=status, mimetype='application/json')



class EditSemester(View):

    def get(self, request, *args, **kwargs):
        semester_id = kwargs['semester_id']
        context = {
            'semester_id': semester_id,
        }
        ctx_data = []
        if request.is_ajax():
            try:
                semester = Semester.objects.get(id = semester_id)
                ctx_data.append({
                    'semester': semester.semester,
                    
                                        
                })
                res = {
                    'result': 'ok',
                    'semester': ctx_data,
                }
                status = 200
            except Exception as ex:
                print "Exception == ", str(ex)
                ctx_college_data = []
                res = {
                    'result': 'error',
                    'semester': ctx_data,
                }
                status = 500
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

        return render(request, 'edit_semester.html',context)

    def post(self, request, *args, **kwargs):

        semester_id = kwargs['semester_id']

        semester = Semester.objects.get(id = semester_id)
        data = ast.literal_eval(request.POST['semester'])
        try:
            semester.semester = data['semester']
            semester.save()
            res = {
                'result': 'ok',
            }
            status = 200
        except Exception as Ex:
            print "Exception == ", str(Ex)
            res = {
                'result': 'error',
                'message': 'Semester with this name is already existing'
            }
            status = 200
        response = simplejson.dumps(res)
        return HttpResponse(response, status=status, mimetype='application/json')



class AddNewCourse(View):
    def post(self, request, *args, **kwargs):

        if request.is_ajax():
            semester_list = ast.literal_eval(request.POST['semester_list'])
            try:
        
                course, created = Course.objects.get_or_create(course=request.POST['course'])
                if not created:
                    res = {
                        'result': 'error',
                        'message': 'Course already existing'
                    }
                    status_code = 200
                else:
                    try:
                        course = Course.objects.get(id = request.POST['course'])
                    
                    except Exception as ex:
                        print str(ex), "Exception ===="
                    course.save()
                    for semester_id in semester_list:
                        course.semester.add(semester_id)
                    res = {
                        'result': 'ok',
                    }  
                    status_code = 200 

            except Exception as ex:
                print str(ex), "Exception ===="
                res = {
                        'result': 'error: ' + str(ex),
                        'message': 'Course Name already existing'
                    }
                status_code = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")

class AddNewSemester(View):
    def post(self, request, *args, **kwargs):

        if request.is_ajax():
            try:

                semester, created = Semester.objects.get_or_create(semester=request.POST['name'])
                if not created:
                    res = {
                        'result': 'error',
                        'message': 'Semester already existing'
                    }
                    status_code = 500
                else:
                    try:
                        semester.semester = request.POST['name']
                    
                    except Exception as ex:
                        print str(ex), "Exception ===="
                    semester.save()
                    res = {
                        'result': 'ok',
                    }  
                    status_code = 200 

            except Exception as ex:
                print str(ex), "Exception ===="
                res = {
                        'result': 'error',
                        'message': 'Semester Name already existing'
                    }
                status_code = 500
            response = simplejson.dumps(res)
            return HttpResponse(response, status = status_code, mimetype="application/json")



class DeleteCourse(View):
    def get(self, request, *args, **kwargs):

        course_id = kwargs['course_id']       
        course = Course.objects.filter(id=course_id)                          
        course.delete()
        return HttpResponseRedirect(reverse('list_course'))

class DeleteSemester(View):
    def get(self, request, *args, **kwargs):

        semester_id = kwargs['semester_id']       
        semester = Semester.objects.filter(id=semester_id)                          
        semester.delete()
        return HttpResponseRedirect(reverse('list_semester'))



class GetSemester(View):

    def get(self, request, *args, **kwargs):        
        semester_list = []
        if request.is_ajax():
            try:
                if request.user.is_superuser:
                    course = Course.objects.get(id=request.GET.get('id'))
                    semesters = course.semester.all()
                else:
                    student = Student.objects.get(user=request.user)
                    semesters = Semester.objects.filter(id=student.semester.id)
            except:
                try:
                    semesters = Semester.objects.all()
                except Exception as ex:
                    res = {
                        'result': 'error: '+ str(ex),
                    }
            for semester in semesters:
                semester_list.append({
                    'semester': semester.semester, 
                    'id': semester.id                
                })
            res = {
                'result': 'ok',
                'semesters': semester_list,
            }
            status = 200
            response = simplejson.dumps(res)
            return HttpResponse(response, status=status, mimetype='application/json')

