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
    
    def line_total(self):
        return self.item.price * self.quantity

class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    items = models.ManyToManyField(OrderItem)
    created_at =models.DateTimeField(auto_now_add=True)
    confirmed = models.BooleanField(default=False)
    delivered =models.BooleanField(default=False)


    def __str__(self) -> str:
        return F"Order {self.user}"
    
    class Meta:
        ordering = ('-created_at',)

    def grand_total(self):
        total = 0 
        

    