from .models import Order
from django.contrib.auth import get_user_model

User = get_user_model()

# test_user = User.objects.create_user(username = 'anon',password=None,last_name='last',first_name='')





def order_processor(request):
    if request.user.is_authenticated:
        user = request.user

        latest_order = Order.objects.filter(user=user).latest('created_at')

        return {
            'current_order':latest_order
        }
    
    else:
        user = User.objects.get(username ='anon')

        order = Order.objects.get_or_create(user = user)

        return {
            'current_order':order
        }

