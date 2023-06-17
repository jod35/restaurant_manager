from django.shortcuts import render

# Create your views here.
def order_items(request):
    return render(request, 'order/index.html')

