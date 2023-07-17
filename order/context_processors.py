from .models import Order
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from datetime import datetime

User = get_user_model()

# username = f'anon_{datetime.now().timestamp()}'
# test_user = User.objects.create_user(username='anon', password=None, last_name='last', first_name='')

# order = Order.objects.create(user=User.objects.get(id=1))


def order_processor(request):

    order = Order.objects.filter(user=request.user).latest('created_at')

    return {
        'current_order' :order
    }
