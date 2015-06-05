
from django.conf.urls import patterns, url
from django.contrib.auth.decorators import login_required

from college.views import *

urlpatterns = patterns('',
	
	url(r'^list_course/$',login_required (ListCourse.as_view()), name='list_course'),
	url(r'^list_semester/$',login_required (ListSemester.as_view()), name='list_semester'),
	url(r'^add_new_course/$',login_required (AddNewCourse.as_view()), name='add_new_course'),
	url(r'^add_new_semester/$',login_required (AddNewSemester.as_view()), name='add_new_semester'),
	
	url(r'^edit_course/(?P<course_id>\d+)/$',login_required (EditCourse.as_view()), name="edit_course"),
	url(r'^delete_course/(?P<course_id>\d+)/$',login_required (DeleteCourse.as_view()), name="delete_course"),
	url(r'^edit_semester/(?P<semester_id>\d+)/$',login_required (EditSemester.as_view()), name="edit_semester"),
	url(r'^delete_semester/(?P<semester_id>\d+)/$',login_required (DeleteSemester.as_view()), name="delete_semester"),
	
    url(r'^get_semester/$',login_required (GetSemester.as_view()), name="get_semester"),  

)