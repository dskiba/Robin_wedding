from django.utils.translation import ugettext_lazy as _
from .base import Menu, MenuItem


def main(request):
    menu = Menu()
    menu.append(
        MenuItem(
            title=_('Photos'),
            url='blog:index',
        ),
        MenuItem(
            title=_('Testimonials'),
            url='testimonials:index',
        ),
        MenuItem(
            title=_('Blog'),
            url='blog:index',
        ),
    )
    return menu

