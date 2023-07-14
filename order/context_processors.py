from .models import Order
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from datetime import datetime

User = get_user_model()

# username = f'anon_{datetime.now().timestamp()}'
# test_user = User.objects.create_user(username='anon', password=None, last_name='last', first_name='')

# order = Order.objects.create(user=User.objects.get(id=1))


def order_processor(request):
    if request.user.is_authenticated:
        user = request.user
        try:
            latest_order = Order.objects.filter(user=user).latest('created_at')
        except Order.DoesNotExist:
            latest_order = None

        return {
            'current_order': latest_order
        }
    else:
        user = get_user_model().objects.get(username='anon')
        order_obj, created = Order.objects.get_or_create(user=user)
        return {
            'current_order': order_obj
        }
