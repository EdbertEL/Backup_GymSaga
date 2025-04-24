from rest_framework import viewsets, permissions
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from rest_framework.views import APIView
from datetime import datetime
import uuid
from .firebase_auth import FirebaseAuthentication
from .models import *
from firebase_admin import auth
from .serializers import *
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
import json

from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import get_user_model
User = get_user_model()
from django.contrib.auth.hashers import make_password

class UserProfileViewSet(viewsets.ModelViewSet):
    queryset = UserProfile.objects.all()
    serializer_class = UserProfileSerializer

class UserFriendViewSet(viewsets.ModelViewSet):
    queryset = UserFriend.objects.all()
    serializer_class = UserFriendSerializer

class WorkoutCategoryViewSet(viewsets.ModelViewSet):
    queryset = WorkoutCategory.objects.all()
    serializer_class = WorkoutCategorySerializer

class ExerciseViewSet(viewsets.ModelViewSet):
    queryset = Exercise.objects.all()
    serializer_class = ExerciseSerializer

class WorkoutPlanViewSet(viewsets.ModelViewSet):
    queryset = WorkoutPlan.objects.all()
    serializer_class = WorkoutPlanSerializer

class WorkoutPlanExerciseViewSet(viewsets.ModelViewSet):
    queryset = WorkoutPlanExercise.objects.all()
    serializer_class = WorkoutPlanExerciseSerializer

class UserWorkoutScheduleViewSet(viewsets.ModelViewSet):
    queryset = UserWorkoutSchedule.objects.all()
    serializer_class = UserWorkoutScheduleSerializer

class WorkoutSessionViewSet(viewsets.ModelViewSet):
    queryset = WorkoutSession.objects.all()
    serializer_class = WorkoutSessionSerializer

class WorkoutSessionExerciseViewSet(viewsets.ModelViewSet):
    queryset = WorkoutSessionExercise.objects.all()
    serializer_class = WorkoutSessionExerciseSerializer

class StepsTrackingViewSet(viewsets.ModelViewSet):
    queryset = StepsTracking.objects.all()
    serializer_class = StepsTrackingSerializer

class WeightLogViewSet(viewsets.ModelViewSet):
    queryset = WeightLog.objects.all()
    serializer_class = WeightLogSerializer

class AchievementViewSet(viewsets.ModelViewSet):
    queryset = Achievement.objects.all()
    serializer_class = AchievementSerializer

class UserAchievementProgressViewSet(viewsets.ModelViewSet):
    queryset = UserAchievementProgress.objects.all()
    serializer_class = UserAchievementProgressSerializer

class DailyQuestViewSet(viewsets.ModelViewSet):
    queryset = DailyQuest.objects.all()
    serializer_class = DailyQuestSerializer

class UserDailyQuestViewSet(viewsets.ModelViewSet):
    queryset = UserDailyQuest.objects.all()
    serializer_class = UserDailyQuestSerializer

class UserNotificationViewSet(viewsets.ModelViewSet):
    queryset = UserNotification.objects.all()
    serializer_class = UserNotificationSerializer

from django.contrib.auth import get_user_model
User = get_user_model()

@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            username = data.get('username')
            email = data.get('email')
            password = data.get('password')
            method = data.get('method')
            uid = data.get('google_uid')

            if not username or not email or not method:
                return JsonResponse({'error': 'Username, email, and method are required'}, status=status.HTTP_400_BAD_REQUEST)

            if User.objects.filter(email=email).exists():
                return JsonResponse({'error': 'Email is already in use'}, status=status.HTTP_400_BAD_REQUEST)

            if method == 'email_login':
                if not password:
                    return JsonResponse({'error': 'Password is required for email login'}, status=status.HTTP_400_BAD_REQUEST)
                user = User.objects.create(
                    username=username,
                    email=email,
                    password=make_password(password)
                )
                uid = data.get('email_uid')
                UserProfile.objects.create(
                    user=user,
                    method=method,
                    uid=uid
                )

            elif method == 'google_login':
                user = User.objects.create(
                    username=username,
                    email=email
                )
                UserProfile.objects.create(
                    user=user,
                    method=method,
                    uid=uid
                )

            else:
                return JsonResponse({'error': 'Invalid method'}, status=status.HTTP_400_BAD_REQUEST)

            return JsonResponse({'message': 'User registered successfully!'}, status=status.HTTP_201_CREATED)

        except json.JSONDecodeError:
            return JsonResponse({'error': 'Invalid JSON'}, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            return JsonResponse({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@authentication_classes([FirebaseAuthentication])
@permission_classes([IsAuthenticated])
def complete_profile(request):
    user = request.user
    data = request.data

    name = data.get('name')
    gender = data.get('gender').lower()
    date_of_birth_str = data.get('date_of_birth')
    weight = float(data.get('weight'))
    height = float(data.get('height'))

    birth_date = datetime.strptime(date_of_birth_str, "%Y-%m-%d")
    today = datetime.today()
    age = today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))

    if gender.lower() == 'male':
        bmr = 10 * weight + 6.25 * height - 5 * age + 5
    else:
        bmr = 10 * weight + 6.25 * height - 5 * age - 161

    calorie_goal = bmr * 1.55

    profile, created = UserProfile.objects.update_or_create(
        user=user,
        defaults={
            "name": name,
            "gender": gender,
            "birth_date": birth_date,
            "current_weight": weight,
            "current_height": height,
            "daily_calorie_goal": round(calorie_goal),
        }
    )

    return Response({"message": "Profile updated successfully!"})

class GoalTypeUpdateView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        goal_type = request.data.get('goal_type')

        if not goal_type:
            return Response({'error': 'goal_type is required'}, status=status.HTTP_400_BAD_REQUEST)

        profile, _ = UserProfile.objects.get_or_create(user=user)
        profile.goal_type = goal_type
        profile.save()

        return Response({'message': 'Goal type updated successfully'}, status=status.HTTP_200_OK)

class WeightGoalUpdateView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        user = request.user
        weight_goal = request.data.get('weight_goal')

        if not weight_goal:
            return Response({'error': 'weight_goal is required'}, status=status.HTTP_400_BAD_REQUEST)

        profile, _ = UserProfile.objects.get_or_create(user=user)
        profile.goal_weight = weight_goal
        profile.save()

        return Response({'message': 'Weight goal updated successfully'}, status=status.HTTP_200_OK)

@api_view(['POST'])
def login_user(request):
    try:
        data = request.data
        token = data.get('token')
        method = data.get('method')  # 'email_login' atau 'google_login'

        if not token or not method:
            return JsonResponse({'error': 'Token and method are required'}, status=400)

        # Verifikasi token dari Firebase
        decoded_token = auth.verify_id_token(token, clock_skew_seconds=60)
        uid = decoded_token['uid']
        email = decoded_token.get('email')
        name = decoded_token.get('name', email.split('@')[0] if email else 'unknown')

        # Cek apakah user sudah terdaftar
        try:
            user_profile = UserProfile.objects.get(uid=uid, method=method)
            user = user_profile.user
            return JsonResponse({
                'message': 'Login successful',
                'user_id': user.id,
                'username': user.username,
                'email': user.email,
                'profile_id': user_profile.id,
                'uid': uid,
                'method': method
            })
        except UserProfile.DoesNotExist:
            return JsonResponse({
                'error': 'User not registered',
                'uid': uid,
                'email': email,
                'name': name,
                'method': method
            }, status=404)

    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)