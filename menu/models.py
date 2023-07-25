from django.db import models
from cloudinary.models import CloudinaryField

CATEGORIES = (
    ('lunch','lunch'),
    ('breakfast','breakfast'),
    ('dinner','dinner')
)

# Create your models here.
class MenuItem(models.Model):
    name = models.CharField(max_length=100)
    price = models.IntegerField()
    image = CloudinaryField('image')
    category = models.CharField(max_length=255,choices=CATEGORIES)
    description = models.TextField()

    def __str__(self) -> str:
        return f"{self.name} @ {self.price}"

    def formatted_price(self):
        return f"{self.price:,}"

