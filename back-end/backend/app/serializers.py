#For restfull API
from django.contrib.auth.models import User, Group
from rest_framework import serializers
from app.models import *
from django.db import models

#Default serializers
class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ('url', 'username', 'email', 'groups')
#Default serializers
class GroupSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Group
        fields = ('url', 'name')

#Serializers for custom models
class StudentSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Student
        fields = ('url', 'name')

class CourseSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Course
        fields = ('url', 'name')

#Question serializer y creator
class QuestionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Question
        fields = ('url',  'id','text', 'user','student')
class QuestionSerializerCreator(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Question
        fields = ('url',  'id','text', 'student')

#Answer Serializer y creator
class AnswerSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Answer
        fields = ('url', 'id', 'question', 'text', 'user','student')
class AnswerSerializerCreator(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Answer
        fields = ('url', 'id', 'question', 'text', 'student')

#QuestionsAndAnswers Serializer
class QASerializer(serializers.ModelSerializer):
    question = serializers.PrimaryKeyRelatedField(queryset=Question.objects.all(),required=False, allow_null=True)
    answer = serializers.PrimaryKeyRelatedField(queryset=Answer.objects.all(),required=False, allow_null=True)
    class Meta:
        model = models.Model
        fields = "__all__"

#Suscription Serializers
class SuscriptionSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Suscription
        fields = "__all__"

class SuscriptionPOSTPUTDELSerializerCreator(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Suscription
        fields = "__all__"