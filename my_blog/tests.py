# 1. 模拟取出某文章的所有评论的部分信息如下,
comment_list = [
    {'id': 1, 'content': '1111', 'parent_id': None, 'children_contents': []},
    {'id': 2, 'content': '2222', 'parent_id': None, 'children_contents': []},
    {'id': 3, 'content': '3333', 'parent_id': 1, 'children_contents': []},
    {'id': 4, 'content': '4444', 'parent_id': 2, 'children_contents': []},
    {'id': 5, 'content': '5555', 'parent_id': 4, 'children_contents': []},
    {'id': 6, 'content': '6666', 'parent_id': 3, 'children_contents': []},
    {'id': 7, 'content': '7777', 'parent_id': 6, 'children_contents': []},
    {'id': 8, 'content': '8888', 'parent_id': None, 'children_contents': []},
]


# 2. 新建数据结构, {1: {'id':1, ...}, 2: {'id':2, ...},}

comment_dict = {}

for d in comment_list:
    id = d.get('id')
    comment_dict[id] = d

'''
{1: {'id': 1, 'content': '...', 'parent_id': None, 'children_contents': []},
2: {'id': 2, 'content': '...', 'parent_id': None, 'children_contents': []},
3: {'id': 3, 'content': '...', 'parent_id': 1, 'children_contents': []},
4: {'id': 4, 'content': '...', 'parent_id': 1, 'children_contents': []},
5: {'id': 5, 'content': '...', 'parent_id': 4, 'children_contents': []},
6: {'id': 6, 'content': '...', 'parent_id': 3, 'children_contents': []},
7: {'id': 7, 'content': '...', 'parent_id': 6, 'children_contents': []},
8: {'id': 8, 'content': '...', 'parent_id': None, 'children_contents': []},
}
'''


# 3. 将每个评论放进其parent_id对应的children_contents列表中
for k in comment_dict:
    parent_id = comment_dict[k]['parent_id']
    if parent_id:
        comment_dict[parent_id]['children_contents'].append(comment_dict[k])

'''
{1: {'id': 1, 'content': '...', 'parent_id': None, 'children_contents': [
    {'id': 3, 'content': '...', 'parent_id': 1, 'children_contents': [],
    {'id': 4, 'content': '...', 'parent_id': 1, 'children_contents': []}
    ]},
    
2: {'id': 2, 'content': '...', 'parent_id': None, 'children_contents': []},
3: {'id': 3, 'content': '...', 'parent_id': 1, 'children_contents': [
    {'id': 6, 'content': '...', 'parent_id': 3, 'children_contents': []},
]},

4: {'id': 4, 'content': '...', 'parent_id': 1, 'children_contents': [
    {'id': 5, 'content': '...', 'parent_id': 4, 'children_contents': []},
    ]},
    
5: {'id': 5, 'content': '...', 'parent_id': 4, 'children_contents': []},
6: {'id': 6, 'content': '...', 'parent_id': 3, 'children_contents': [
    {'id': 7, 'content': '...', 'parent_id': 6, 'children_contents': []},
]},

7: {'id': 7, 'content': '...', 'parent_id': 6, 'children_contents': []},
8: {'id': 8, 'content': '...', 'parent_id': None, 'children_contents': []},
}
'''


# 4. 筛选出所有的根评论, 整理成列表形式
res_list = []
for i in comment_dict:
    if not comment_dict[i]['parent_id']:
        res_list.append(comment_dict[i])

res_list = [
    {
	'id': 1,
	'content': '1111',
	'parent_id': None,
	'children_contents': [{
		'id': 3,
		'content': '3333',
		'parent_id': 1,
		'children_contents': [{
			'id': 6,
			'content': '6666',
			'parent_id': 3,
			'children_contents': [{
				'id': 7,
				'content': '7777',
				'parent_id': 6,
				'children_contents': []
			}]
		}]
	}]
},
    {
	'id': 2,
	'content': '2222',
	'parent_id': None,
	'children_contents': [{
		'id': 4,
		'content': '4444',
		'parent_id': 2,
		'children_contents': [{
			'id': 5,
			'content': '5555',
			'parent_id': 4,
			'children_contents': []
		}]
	}]
},
    {
	'id': 8,
	'content': '8888',
	'parent_id': None,
	'children_contents': []
}]



# 6. 遍历根评论(最关键)
'''
根评论1 
    子评论1
    子评论1

根评论2
    子评论3
    子评论4

跟评论3
    子评论5        
    子评论6
'''

def get_content(list):
    for d in list:
        print(d['content'])
        if d['children_contents']:
            get_content(d['children_contents'])


get_content(res_list)

'''
1111
	3333
		6666
			7777
2222
	4444
		5555

8888
'''




