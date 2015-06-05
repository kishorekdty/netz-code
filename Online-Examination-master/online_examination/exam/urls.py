
from django.conf.urls import patterns, url

from exam.views import (ScheduleExam, ViewExamSchedule, EditExamSchedule, \
	SaveExamSchedule, DeleteExamSchedule, CreateQuestion, GetExams,GetExamCreate, SaveQuestions, CreateExam, \
	WriteExam, QuestionPaper, CreateAnswerSheet, EditQuestion, GetSubjects, ListQuestions, DeleteQuestion)

urlpatterns = patterns('',	
	url(r'^schedule_exam/$', ScheduleExam.as_view(), name='schedule_exam'),
	url(r'^view_exam_schedule/(?P<exam_schedule_id>\d+)/$', ViewExamSchedule.as_view(), name="view_exam_schedule"),
	url(r'^edit_exam_schedule/(?P<exam_schedule_id>\d+)/$', EditExamSchedule.as_view(), name="edit_exam_schedule"),
	url(r'^save_new_exam_schedule/$', SaveExamSchedule.as_view(), name='save_new_exam_schedule'),
	url(r'^delete_exam_schedule/(?P<exam_schedule_id>\d+)/$', DeleteExamSchedule.as_view(), name="delete_exam_schedule"),
	url(r'^create_questions/$', CreateQuestion.as_view(), name='create_questions'),
	url(r'^get_exam/(?P<course_id>\d+)/(?P<semester_id>\d+)/$', GetExams.as_view(), name="get_exam"),
	url(r'^get_exam_create/(?P<course_id>\d+)/(?P<semester_id>\d+)/$', GetExamCreate.as_view(), name="get_exam_create"),
	url(r'^save_questions/$', SaveQuestions.as_view(), name='save_questions'),
	url(r'^create_exam/$', CreateExam.as_view(), name='create_exam'),
	url(r'^write_exam/$', WriteExam.as_view(), name='write_exam'),
	url(r'^list_subject/$', GetSubjects.as_view(), name='list_subject'),
	url(r'^get_questions/$', QuestionPaper.as_view(), name='get_questions'),
	url(r'^list_questions/$', ListQuestions.as_view(), name='list_questions'),
	url(r'^edit_question/(?P<question_id>\d+)/$', EditQuestion.as_view(), name="edit_question"),
	url(r'^delete_question/(?P<question_id>\d+)/$', DeleteQuestion.as_view(), name="delete_question"),
	url(r'^create_answersheet/$', CreateAnswerSheet.as_view(), name='create_answersheet'),
)