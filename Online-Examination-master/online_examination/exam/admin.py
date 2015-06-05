from django.contrib import admin
from exam.models import *

admin.site.register(Subject)
admin.site.register(Exam)
admin.site.register(Question)
admin.site.register(Choice)
admin.site.register(StudentAnswer)
admin.site.register(AnswerSheet)
