from django.db import models
from menu.models import MenuItem
from django.contrib.auth import get_user_model

User = get_user_model()

# Create your models here.
class OrderItem(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    item = models.ForeignKey(MenuItem,on_delete=models.CASCADE)
    phone =models.CharField(max_length=10)
    quantity = models.IntegerField(default=1)
    
    def __str__(self) -> str:
        return f"{self.item.name} at {self.created_at}"

class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    items = models.ManyToManyField(OrderItem)
    created_at =models.DateTimeField(auto_now_add=True)


    def __str__(self) -> str:
        return F"Order {self.user}"

    