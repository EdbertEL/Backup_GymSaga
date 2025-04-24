import firebase_admin
from firebase_admin import auth
from rest_framework import viewsets
<<<<<<< HEAD
from rest_framework.permissions import IsAuthenticated
from .models import User
from .serializers import UserSerializer
=======
from .serializers import (
    UserSerializer
    )
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from authentication.models import User
>>>>>>> 0476b3c (backend register login + google)

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

<<<<<<< HEAD
    def partial_update(self, request, *args, **kwargs):
        instance = self.get_object()
        if 'username' in request.data:
            instance.username = request.data['username']
            instance.save()
        return super().partial_update(request, *args, **kwargs)
=======
class EmailLoginView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        user = authenticate(request, username=username, password=password)

        if user is not None:
            # Token bisa pakai Simple JWT atau session, contoh dummy response:
            return Response({
                'message': 'Login successful',
                'user_id': user.id,
                'username': user.username,
            })
        return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)

class GoogleLoginView(APIView):
    def post(self, request):
        id_token = request.data.get('id_token')
        try:
            decoded_token = auth.verify_id_token(id_token)
            uid = decoded_token['uid']
            email = decoded_token.get('email')

            user, created = User.objects.get_or_create(
                email=email,
                defaults={
                    'username': email.split('@')[0],
                    'auth_provider': 'google',
                    'auth_provider_id': uid,
                }
            )

            return Response({
                'message': 'Login successful',
                'user_id': user.id,
                'username': user.username,
                'created': created,
            })
        except Exception as e:
            return Response({'error': str(e)}, status=400)
>>>>>>> 0476b3c (backend register login + google)
