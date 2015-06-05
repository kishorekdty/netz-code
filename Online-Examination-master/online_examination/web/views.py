import simplejson

from django.views.generic.base import View
from django.shortcuts import get_object_or_404, render
from django.http import Http404, HttpResponse, HttpResponseRedirect
from django.template import RequestContext
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.core.urlresolvers import reverse
from exam.models import *
from academic.models import Student

class Home(View):
    def get(self, request, *args, **kwargs):

        context = {
            
        }
        return render(request, 'home.html',context)# Create your views here.
class Login(View):
    def get(self,request,*args,**kwargs):
        if request.user.is_authenticated():
            return HttpResponseRedirect(reverse('home'))
        return render_to_response('home.html',{},RequestContext(request))

    def post(self,request,*args,**kwargs):
        if request.POST.get('username', '') and request.POST.get('password',''):
            username = request.POST.get('username', '')
            user = authenticate(username=request.POST.get('username', ''), password=request.POST.get('password',''))
            if user and user.is_active:
                login(request, user)
            else:
                context = {
                    'message' : 'Username or password is incorrect'
                }
                return render(request, 'home.html',context)
        elif request.POST.get('registration_no','') and request.POST.get('hallticket_no','') and request.POST.get('password',''):
            username = request.POST.get('registration_no','') + request.POST.get('hallticket_no','')
            user = authenticate(username=username, password=request.POST.get('password',''))
            
            student = Student.objects.get(user=user)
            if user and user.is_active and student.is_curently_logged_in==False:
                login(request, user)
                student.is_curently_logged_in = True
                student.save()
            else:
                context = {
                    'message' : 'Username or password is incorrect'
                }
                return render(request, 'home.html',context)
        
        context = {
         'Success_message': 'Welcome '+username
        }
        return HttpResponseRedirect(reverse('home'))

class Logout(View):
    def get(self,request,*args,**kwargs):
        if not request.user.is_superuser:
            student = Student.objects.get(user=request.user)
            student.is_curently_logged_in = False
            student.save()
            logout(request)
        else:
            logout(request)
        return HttpResponseRedirect(reverse('home'))

class ResetPassword(View):

    def get(self, request, *args, **kwargs):

        user = User.objects.get(id=kwargs['user_id'])
        context = {
            'user_id': user.id
        }
        return render(request, 'reset_password.html', context)

    def post(self, request, *args, **kwargs):

        context = {}
        user = User.objects.get(id=kwargs['user_id'])
        if request.POST['password'] != request.POST['confirm_password']:
            context = {
                'user_id': user.id,
                'message': 'Password is not matched with Confirm Password',
            }
            return render(request, 'reset_password.html', context)
        if len(request.POST['password']) > 0 and not request.POST['password'].isspace():
            user.set_password(request.POST['password'])
        user.save()
        if user == request.user:
            logout(request)
            return HttpResponseRedirect(reverse('home'))  
        else:
            user_type = user.userprofile_set.all()[0].user_type 
            return HttpResponseRedirect(reverse('users', kwargs={'user_type': user_type}))


class StudentResults(View):
    def get(self, request, *args, **kwargs):
        if request.is_ajax():
            exam_results = []
            result={}
            student_details = []
            mark_percentage=0,
            exam_resgistration_no = request.GET.get('exam_resgistration_no')
            print(exam_resgistration_no)
            try:
                student_data = Student.objects.get(registration_no=exam_resgistration_no)
                print(student_data)
                student_details.append(student_data.get_json_data())
                print(student_details)
                answer_sheets = AnswerSheet.objects.filter(student__registration_no=exam_resgistration_no)
                print(answer_sheets)
                if len(answer_sheets) == 0:
                    
                    res = {
                        'result': 'error',
                        'message':'Student with this Registration number doesnt write any exams'
                    }
                else : 
                    print("ok")   
                    for answer_sheet in answer_sheets:
                        print(answer_sheet)
                        result=answer_sheet.get_json_data()
                        print(result)
                        # exam_results.append(answer_sheet.get_json_data())
                        mark_percentage=(float(result['total_mark'])/float(result['subject_total_mark']))*100
                        print(mark_percentage)
                        result['percentage'] = mark_percentage;
                        exam_results.append(result)
                        # exam_results.append('percentage':mark_percentage)

                        print exam_results
                        res = {
                            'result': 'Ok',
                            'exam_results': exam_results,
                            'student_details':student_details,
                        }

            except:
                res = {
                    'result': 'error',
                    'message':'There is no student with this Registration number'
                }
            
            
            response = simplejson.dumps(res)
            return HttpResponse(response, mimetype='application/json')
        return render(request, 'student_results.html', {}) 
