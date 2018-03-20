# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com

from django import forms
from django.forms import widgets


class RegisterForm(forms.Form):
    username = forms.CharField(min_length=2, widget=widgets.TextInput(attrs={"placeholder":"用户名", "class":"form-control"}))
    password1 = forms.CharField(min_length=4, widget=widgets.PasswordInput(attrs={"placeholder":"密码1", "class":"form-control"}))
    password2 = forms.CharField(min_length=4, widget=widgets.PasswordInput(attrs={"placeholder":"密码2", "class":"form-control"}))
    email = forms.EmailField(max_length=50, widget=widgets.EmailInput(attrs={"placeholder":"邮箱", "class":"form-control"}))
    valid_code = forms.CharField(min_length=6, max_length=6, widget=widgets.TextInput(attrs={"placeholder":"验证码", "class":"form-control"}))



