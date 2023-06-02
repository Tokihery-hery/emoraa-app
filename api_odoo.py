


import xmlrpc.client
url = "http://192.168.88.245:8069"
db = "odoopdv"
username = 'tokihery15@gmail.com'
password = "tokihery"


common = xmlrpc.client.ServerProxy('{}/xmlrpc/2/common'.format(url))
models = xmlrpc.client.ServerProxy('{}/xmlrpc/2/object'.format(url))
uid = common.authenticate(db, username, password, {})

res_partners= models.execute_kw(db, uid, password, 'res.partner', 'search_read', [[]], {'fields': ['name', 'country_id', 'comment']})
print(res_partners)