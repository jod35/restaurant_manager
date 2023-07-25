

from django.contrib import admin
from django.http import HttpResponse
from django.db.models import Count, Sum
from django.db.models.functions import ExtractMonth
from io import BytesIO
import base64
import json
from django.utils.html import format_html
from .models import OrderItem, Order


from matplotlib import pyplot as plt
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas
from django.utils import timezone




@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('user', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('user__username', 'user__email')
    date_hierarchy = 'created_at'

    actions = ['generate_pdf_report']

    def generate_pdf_report(self, request, queryset):
        response = HttpResponse(content_type='application/pdf')
        response['Content-Disposition'] = 'attachment; filename="order_report.pdf"'

        p = canvas.Canvas(response, pagesize=letter)
        p.setFont("Helvetica", 12)

        for order in queryset:
            for order_item in order.items.all():
                created_at = timezone.localtime(order.created_at)
                created_at_str = created_at.strftime('%Y-%m-%d %I:%M %p')

                p.drawString(100, 700, f"User: {order.user}")
                p.drawString(100, 680, f"Item: {order_item.item.name}")
                p.drawString(100, 660, f"Quantity: {order_item.quantity}")
                p.drawString(100, 640, f"Phone Number: {order_item.phone}")
                p.drawString(100, 620, f"Created At: {created_at_str}")

                p.showPage()

        p.save()
        return response
    
    def changelist_view(self, request, extra_context=None):
        extra_context = extra_context or {}
        extra_context['analytics'] = self.get_analytics()
        return super().changelist_view(request, extra_context=extra_context)

    def get_analytics(self):
        # Get the most ordered products
        most_ordered_products = OrderItem.objects.values('item__name').annotate(total_ordered=Count('item')).order_by('-total_ordered')[:5]

        # Get monthly order totals
        monthly_order_totals = Order.objects.annotate(month=ExtractMonth('created_at')).values('month').annotate(total_amount=Sum('items__quantity')).order_by('month')

        # Prepare data for the graphs
        product_labels = [product['item__name'] for product in most_ordered_products]
        product_values = [product['total_ordered'] for product in most_ordered_products]
        month_labels = [f'Month {record["month"]}' for record in monthly_order_totals]
        month_values = [record['total_amount'] for record in monthly_order_totals]

        # Create the JSON data for the graphs
        graph_data = {
            'most_ordered_products': {
                'labels': product_labels,
                'values': product_values,
            },
            'monthly_order_totals': {
                'labels': month_labels,
                'values': month_values,
            },
        }

        # Convert the graph data to JSON and encode to base64
        graph_images = base64.b64encode(json.dumps(graph_data).encode('utf-8')).decode('utf-8')

        # Return the base64-encoded graphs
        return graph_images
    
    change_list_template = 'order/order_change_list.html'


@admin.register(OrderItem)
class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('item', 'quantity', 'phone')
