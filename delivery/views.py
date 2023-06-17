from django.shortcuts import render
from django.views.generic import TemplateView

# Create your views here.
def delivery_items(request):
    return render(request, 'delivery/index.html')


class DeliveryItemsView(TemplateView):
    template_name = 'delivery.html'
