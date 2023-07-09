from .models import Order


def order_processor(request):

    order = Order.objects.filter(user=request.user).latest('created_at')

    return {
        'current_order' :order
    }