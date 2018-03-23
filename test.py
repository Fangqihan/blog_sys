# -*- coding: utf-8 -*-   @Time    : 18-1-25 下午6:58
# @Author  : QiHanFang    @Email   : qihanfang@foxmail.com
from string import ascii_letters, digits
import random
from datetime import datetime

# print(datetime.now())
now = datetime.now()
date1 = datetime.now().replace(year=2011, month=2)
# print(date1)
print(type(now-date1))
print(now.month-date1.month)
