# Generated by Django 4.2.3 on 2023-07-08 18:12

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('menu', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='menuitem',
            name='category',
            field=models.CharField(choices=[('lunch', 'lunch'), ('breakfast', 'breakfast'), ('dinner', 'dinner')], max_length=255),
        ),
    ]
