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

#Modelo de preguntas
class Question(models.Model):
    question = models.CharField(max_length=500, blank=False, default='')
    user =  models.ForeignKey(Student, on_delete=models.CASCADE)
    def __str__(self):
        return self.user + " " + self.question


#Modelo de Respuesta
class Answer(models.Model):
    answer = models.CharField(max_length=500,blank=False, default='')
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    user =  models.ForeignKey(Student, on_delete=models.CASCADE)
    def __str__(self):
        return self.user + " " + self.answer
