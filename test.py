# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com
from string import ascii_letters, digits
import random


def generate_code():
    code = "".join(random.sample(ascii_letters + digits, 6))
    return code

generate_code()
