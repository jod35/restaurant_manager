# Generated by Django 4.2.3 on 2023-07-11 08:58

from django.db import migrations


class Migration(migrations.Migration):
    dependencies = [
        ("order", "0003_order_delivered"),
    ]

    operations = [
        migrations.AlterModelOptions(
            name="order",
            options={"ordering": ("-created_at",)},
        ),
    ]
