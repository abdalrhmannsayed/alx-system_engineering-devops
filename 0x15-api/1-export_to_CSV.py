#!/usr/bin/python3
'''A script that gathers employee name completed
tasks and total number of tasks from an typicode API
'''

import re
import requests
import sys

REST_API = "https://jsonplaceholder.typicode.com"

if __name__ == '__main__':
    if len(sys.argv) > 1:
        if re.fullmatch(r'\d+', sys.argv[1]):
            id = int(sys.argv[1])
            emp_req = requests.get('{}/users/{}'.format(REST_API, id)).json()
            task_req = requests.get('{}/todos'.format(REST_API)).json()
            emp_name = emp_req.get('username')
            tasks = list(filter(lambda x: x.get('userId') == id, task_req))
            # Write the data to a CSV file
            with open('{}.csv'.format(id), 'w') as file:
                for task in tasks:
                    file.write(
                        '"{}","{}","{}","{}"\n'.format(
                            id,
                            emp_name,
                            task.get('completed'),
                            task.get('title')
                        )
                    )
