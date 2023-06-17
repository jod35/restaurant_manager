from django.shortcuts import render

# Create your views here.
def reservation(request):
    return render(request, 'reservation/index.html')

