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
        line_total = self.item.price * self.quantity
        return f"{line_total:,}"
    
    

class Order(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    items = models.ManyToManyField(OrderItem)
    created_at =models.DateTimeField(auto_now_add=True)
    confirmed = models.BooleanField(default=False)
    delivered =models.BooleanField(default=False)


    def __str__(self) -> str:
        return F"Order {self.user}"
    

    def cart_total(self):
        total_price = 0
        for item in self.items.all():
            total_price += (item.quantity * item.item.price)

        return f'{total_price:,}'
    
    class Meta:
        ordering = ('-created_at',)

    def grand_total(self):

        total_price = 0
        for item in self.items.all():
            total_price += (item.quantity * item.item.price)
        return total_price

    