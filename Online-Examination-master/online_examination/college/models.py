from django.db import models



class Semester(models.Model):
	semester = models.CharField('Semester Name', null=True, blank=True, max_length=200)
	def __unicode__(self):
		return (self.semester)
	class Meta:
		verbose_name = 'Semester'
		verbose_name_plural = 'Semester'
		
class Course(models.Model):
	course = models.CharField('Course Name', null=True, blank=True, max_length=200,unique=True)
	semester = models.ManyToManyField(Semester, null=True, blank=True)
	def __unicode__(self):
		return (self.course)
	class Meta:
		verbose_name = 'Course'
		verbose_name_plural = 'Course'



