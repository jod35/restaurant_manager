from django.shortcuts import render ,redirect
from django.urls import reverse
from .forms import UserRegistrationForm
from django.contrib import messages
from django.contrib.auth import login as auth_login ,authenticate

# Create your views here.

def register(request):
    form = UserRegistrationForm()

    if request.method == "POST":
        form = UserRegistrationForm(request.POST)
        
        if form.is_valid():
            form.save()


            username = form.cleaned_data['username']
            password = form.cleaned_data['password1']

            user = authenticate(username = username, password=password)
            print(user)

            if user is not None:
                auth_login(request,user)

            messages.success(request,"User Created Successfully")

            return redirect(reverse('homepage'))


    return render(request,'auth/signup.html',{'form':form} )