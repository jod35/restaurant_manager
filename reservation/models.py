from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

# Create your models here.
class Reservation(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateField()
    time = models.TimeField()
    guest_name = models.CharField(max_length=225)
    created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'Reservation for {self.user.username} on {self.date}'
