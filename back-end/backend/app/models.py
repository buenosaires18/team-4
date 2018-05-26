from django.db import models

# Create your models here.

class Student(models.Model):
    name = models.CharField(max_length=100, blank=False, default='Estudiante X')
    def __str__(self):
        return self.name

class Organizer(models.Model):
    name = models.CharField(max_length=100, blank=False, default='Organizador X')
    def __str__(self):
        return self.name

class Course(models.Model):
    name = models.CharField(max_length=100, blank=False, default='Curso X')
    def __str__(self):
        return self.name

class Suscription(models.Model):
    student =  models.ForeignKey(Student, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    user = models.CharField(max_length=100, blank=True, default='')
    course_name = models.CharField(max_length=100, blank=True, default='')
    terminado = models.BooleanField(default=False)

#Modelo de preguntas
class Question(models.Model):
    text = models.CharField(max_length=500, blank=False, default='')
    student =  models.ForeignKey(Student, on_delete=models.CASCADE)
    user = models.CharField(max_length=100, blank=True, default='')
    def __str__(self):
        return self.student.name + " " + self.text


#Modelo de Respuesta
class Answer(models.Model):
    text = models.CharField(max_length=500,blank=False, default='')
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    student =  models.ForeignKey(Student, on_delete=models.CASCADE)
    user = models.CharField(max_length=100, blank=True, default='')
    

    def __str__(self):
        return self.text

