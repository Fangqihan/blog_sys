# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com
from string import ascii_letters, digits
import random
from random import randint


def generate_code():
    """生成六位数随机验证码"""
    code = "".join(random.sample(ascii_letters + digits, 6))
    return code


def get_random_color():
    return (randint(0, 255), randint(0, 255), randint(0, 255))