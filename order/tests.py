from django.test import TestCase

# Create your tests here.


class OrderItemsTest(TestCase):
    def test_order_items_page_returns_200(self):
        
        response = self.client.get('/orders/order_items/')

        self.assertEqual(response.status_code,302)
        self.assertRedirects(response,'/auth/login/')