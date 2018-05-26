from django.shortcuts import render
# Restfull imports:
from django.contrib.auth.models import User, Group
from rest_framework import viewsets
from rest_framework.views import APIView


from django.http import HttpResponse, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import JSONParser

# Models and serializers import
from app.serializers import *
from app.models import *

#Default ViewSet
class UserViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows users to be viewed or edited.
    """
    queryset = User.objects.all().order_by('-date_joined')
    serializer_class = UserSerializer

class GroupViewSet(viewsets.ModelViewSet):
    """
    API endpoint that allows groups to be viewed or edited.
    """
    queryset = Group.objects.all()
    serializer_class = GroupSerializer

#Student ViewSet
class StudentViewSet(viewsets.ModelViewSet):
    queryset = Student.objects.all()
    serializer_class = StudentSerializer
#Course ViewSet
class CourseViewSet(viewsets.ModelViewSet):
    queryset = Course.objects.all()
    serializer_class = CourseSerializer

#Question ViewSet
class QuestionViewSet(viewsets.ModelViewSet):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializerCreator

#Answer ViewSet
class AnswerViewSet(viewsets.ModelViewSet):
    queryset = Answer.objects.all()
    serializer_class = AnswerSerializerCreator

#Suscription ViewSet
class SuscriptionViewSet(viewsets.ModelViewSet):
    queryset = Suscription.objects.all()
    serializer_class = SuscriptionSerializer

@csrf_exempt
def student_list(request):
    serializer_context = {
            'request': request,
        }
    if request.method == 'GET':
        students = Student.objects.all()
        serializer = StudentSerializer(students, many=True,context=serializer_context)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = StudentSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def course_list(request):
    serializer_context = {
            'request': request,
        }
    if request.method == 'GET':
        course = Course.objects.all()
        serializer = CourseSerializer(course, many=True,context=serializer_context)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = CourseSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def question_list(request):
    serializer_context = {
            'request': request,
        }
    if request.method == 'GET':
        question = Question.objects.all()
        for q in question:
            q.user = q.student.name
        serializer = QuestionSerializer(question, many=True,context=serializer_context)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = QuestionSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def answer_list(request, pk):
    serializer_context = {
            'request': request,
        }
    if request.method == 'GET':
        answer = Answer.objects.filter(question_id=pk)
        for a in answer:
            a.user = a.student.name
        serializer = AnswerSerializer(answer, many=True,context=serializer_context)
        return JsonResponse(serializer.data, safe=False)

    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = AnswerSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def suscription_list(request):
    serializer_context = {
            'request': request,
        }
    if request.method == 'GET':
        suscription = Suscription.objects.all()
        for s in suscription:
            s.user = s.student.name
            s.course_name = s.course.name
        serializer = SuscriptionSerializer(suscription, many=True,context=serializer_context)
        return JsonResponse(serializer.data, safe=False)

    if request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = SuscriptionSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

    if request.method == 'PUT': 
        data = JSONParser().parse(request)
        serializer = SuscriptionSerializer(data=data,context=serializer_context)
        if serializer.is_valid():
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def suscription_detail(request, pk):
    serializer_context = {
            'request': request,
        }
    try:
        print("El pk es: " + pk)
        suscription = Suscription.objects.get(id=pk)
    except Suscription.DoesNotExist:
        return HttpResponse(status=404)

    if request.method == 'DELETE':
        suscription.delete()
        return HttpResponse(status=204)