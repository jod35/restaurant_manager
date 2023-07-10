from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.urls import reverse
from django.contrib.auth.decorators import login_required

from menu.models import MenuItem
from .models import Order, OrderItem
from django.shortcuts import render
from reportlab.pdfgen import canvas
from django.http import HttpResponse
from django.db.models import Sum

@login_required
def create_new_order(request):
    if request.method == "POST":
        user = request.user
        new_order = Order.objects.create(user=user)

        new_order.save()
        return redirect(reverse('menu_items'))
    
    return redirect(reverse('homepage'))


@login_required
def add_order_item(request, item_id):
    menu_item = get_object_or_404(MenuItem, id=item_id)

    if request.method == 'POST': 
        user = request.user
        menu_item_id = request.POST.get('menu_item')
        quantity = request.POST.get('quantity')
        phone_number = request.POST.get('phone_number')

        try:
            menu_item = MenuItem.objects.get(pk=menu_item_id)
            # Process the order and save it to the database
            order_item = OrderItem.objects.create(user=user, item=menu_item, quantity=quantity,phone=phone_number)

            order_item.save()

            order = Order.objects.filter(user=request.user).latest('created_at')

            order.items.add(order_item)

            order.save()

            print("Item added")

            messages.success(request,"Item added successfully")

            return redirect('menu_items')
        except MenuItem.DoesNotExist:
            messages.error(request, "Order not created")
            print("Order not created")
            return redirect(reverse('menu_items'))

    return render(request, 'order/make_order.html', {'selected_item': menu_item})

@login_required
def order_items(request):
    orders = Order.objects.all()
   
    first_item = orders.first().items.first()

    return render(request, 'order/order_items.html',{'orders':orders,'first_item':first_item})


@login_required
def order_item_detail(request,item_id):
    order = get_object_or_404(Order,id=item_id)

    total_price = order.items.all().aggregate(total_price=Sum('item__price'))

    return render(request,'order/order_details.html',{'order':order,'total_price':total_price['total_price']})

@login_required
def delete_item_from_order(request,order_id,item_id):
    order = get_object_or_404(Order, pk=order_id)
    item = get_object_or_404(OrderItem, pk=item_id)
    
    order.items.remove(item)

    return redirect(reverse('order_detail',kwargs={'item_id':item.id}))


@login_required
def delete_order(request,order_id):
    order = get_object_or_404(Order,id=order_id)

    order.delete()

    return redirect(reverse('order_items'))


def generate_report(request):
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = 'attachment; filename="order_report.pdf"'

    # Create a canvas object with the response
    p = canvas.Canvas(response)

    # Fetch the orders
    orders = Order.objects.all()

    # Set the starting y-coordinate for the report
    y = 800

    # Iterate over the orders and add them to the report
    for order in orders:
        for order_item in order.items.all():
            order_name = order_item.item.name
            quantity = order_item.quantity
            created_at = order_item.created_at.strftime('%Y-%m-%d %H:%M:%S')
            order_user = order.user.username
            user_name = order.user.get_full_name()
            phone_number = order_item.phone

            # Write the order details to the report
            p.drawString(100, y, f"Order Name: {order_name}")
            p.drawString(100, y - 20, f"Quantity: {quantity}")
            p.drawString(100, y - 40, f"Time Created: {created_at}")
            p.drawString(100, y - 60, f"Order User: {order_user}")
            p.drawString(100, y - 80, f"User Name: {user_name}")
            p.drawString(100, y - 100, f"Phone Number: {phone_number}")

            # Adjust the y-coordinate for the next order
            y -= 120

    # Save the PDF canvas
    p.save()

    return response



