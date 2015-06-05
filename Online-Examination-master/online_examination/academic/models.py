
from django.db import models
from django.contrib.auth.models import User
from college.models import Course, Semester

SOURCE = (
	('Newspaper','Newspaper'),
	('Ad','Ad'),
	('Website','Website'),
	)
class Student(models.Model):

	student_name = models.CharField('Student Name', null=True, blank=True, max_length=200)
	user = models.ForeignKey(User, null=True, blank=True)
	source = models.CharField('Source of Information', max_length=200, choices=SOURCE, null=True, blank=True)
	is_curently_logged_in = models.BooleanField('Currently Logged In',default=False)
	student_password = models.CharField('Student Password', null=True, blank=True, max_length=200)
	registration_no = models.CharField('Roll Number', null=True, blank=True, max_length=200 )
	hall_ticket_no = models.CharField('Hall Ticket Number', null=True, blank=True, max_length=200 )
	address = models.CharField('Student Address', null=True, blank=True, max_length=200 )
	course = models.ForeignKey(Course, null=True, blank=True)
	specialization = models.CharField('Specialization', null=True, blank=True, max_length=200)
	semester = models.ForeignKey(Semester, null=True, blank=True)
	dob = models.DateField('Date of Birth',null=True, blank=True)
	age = models.CharField('Age',null=True, blank=True, max_length=200 )
	permanent_address= models.CharField('Permanent Address',null=True, blank=True, max_length=200)
	mobile_number= models.CharField('Mobile Number',null=True, blank=True, max_length=200)
	email = models.CharField('Email',null=True, blank=True, max_length=200)
	photo = models.ImageField(upload_to = "uploads/photos/", null=True, blank=True)
	father_name = models.CharField('Father', null=True, blank=True, max_length=200)
	guardian_mobile_number= models.CharField('Guardian Mobile Number',null=True, blank=True, max_length=200)
	pass_out_year = models.CharField('Pass Out Year',null=True, blank=True, max_length=200)

	def __unicode__(self):
		return str(self.student_name)
		
	class Meta:
		verbose_name = 'Student'
		verbose_name_plural = 'Student'
	def get_json_data(self):
		student_data={
			'id':self.id,
			'student_name':self.student_name,
			'source':self.source,
			'registration_no':self.registration_no,
			'hall_ticket_no':self.hall_ticket_no,
			'address':self.address,
			'course':self.course.course,
			'specialization':self.specialization,
			'photo':self.photo.name,
			'semester':self.semester,
			'dob':str(self.dob),
			'age':self.age,
			'permanent_address':self.permanent_address,
			'mobile_number':self.mobile_number,
			'email':self.email,
			'father_name':self.father_name,
			'guardian_mobile_number':self.guardian_mobile_number,
			'pass_out_year':self.pass_out_year,
		}	
		return student_data

