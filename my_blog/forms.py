# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com

from django import forms
from django.forms import widgets
from django.forms import ValidationError


class RegisterForm(forms.Form):
    username = forms.CharField(min_length=2, widget=widgets.TextInput(attrs={"placeholder": "用户名", "class": "form-control"}))
    password1 = forms.CharField(min_length=4, widget=widgets.PasswordInput(attrs={"placeholder": "密码1", "class": "form-control"}))
    password2 = forms.CharField(min_length=4, widget=widgets.PasswordInput(attrs={"placeholder": "密码2", "class": "form-control"}))
    email = forms.EmailField(max_length=50, widget=widgets.EmailInput(attrs={"placeholder": "邮箱", "class": "form-control"}))
    valid_code = forms.CharField(min_length=6, max_length=6, widget=widgets.TextInput(attrs={"placeholder": "验证码", "class": "form-control"}))

    def __init__(self, request, *args, **kwargs):
        super(RegisterForm, self).__init__(*args, **kwargs)
        self.request = request

    # def clean_password1(self):
    #     if self.cleaned_data['password1'].isalpha() or self.cleaned_data['password1'].isdigit():
    #         raise ValidationError('密码不能全为数字或者字母')
    #
    #     else:
    #         return self.cleaned_data['password1']
    #
    # def clean_password2(self):
    #     if len(self.cleaned_data['password2']) < 6:
    #         raise ValidationError('密码长度小于六位')
    #     elif self.cleaned_data['password2'].isalpha() or self.cleaned_data['password2'].isdigit():
    #         raise ValidationError('密码不能全为数字或者字母')
    #     else:
    #         return self.cleaned_data['password2']
    #

    def clean_valid_code(self):
        if self.cleaned_data["valid_code"].upper() == self.request.session["valid_code"].upper():
            return self.cleaned_data["valid_code"]
        else:
            raise ValidationError("验证码错误！")

    def clean(self):
        if self.cleaned_data.get('password1','') == self.cleaned_data.get('password2',''):
            return self.cleaned_data
        else:
            raise ValidationError("密码不一致")