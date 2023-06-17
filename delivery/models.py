from django.db import models
from django.contrib.auth import get_user_model
from order.models import Order


User = get_user_model()

# Create your models here.

class Delivery(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    address = models.CharField(max_length=255)
    delivered = models.BooleanField(default=False)
    delivery_date = models.DateField()
    delivery_time = models.TimeField()

    def __str__(self):
        return f'Delivery for {self.order} at {self.address}'
    
    class Meta:
        verbose_name_plural = "Deliveries"