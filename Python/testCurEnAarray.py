import subprocess
import time


ips = [
    '{\\"title\\": \\"foo\\", \\"body\\": \\"bar\\",\\"userId\\": 1}',
    '{\\"title\\": \\"foo\\", \\"body\\": \\"bar\\",\\"userId\\": 2}',
    '{\\"title\\": \\"foo\\", \\"body\\": \\"bar\\",\\"userId\\": 3}'
]



for ip in ips:

    comando = f"""curl -X POST \"https://jsonplaceholder.typicode.com/posts\" -H \"Content-Type: application/json\" -d \"{ip}\" --connect-timeout 1 --max-time 3 """
    response = subprocess.run(comando, shell=True, capture_output=True, text=True)
    print(response)
    time.sleep(5)


# CompletedProcess(
    # args='curl -X POST "https://jsonplaceholder.typicode.com/posts" -H "Content-Type: application/json" 
    # -d "{
    #     \\"title\\": \\"foo\\", \\"body\\": \\"bar\\",\\"userId\\": 1
    #     }" 
    # --connect-timeout 1 
    # --max-time 3 ', 
    #returncode=0, 
    #stdout='
    #    {
    #        "title": "foo",
    #        "body": "bar",
    #        "userId": 1,
    #        "id": 101
    #    }', 
    #stderr='  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
    #Dload Upload   Total   Spent    Left  Speed
    #
    #  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    #  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
    #100   108  100    65  100    43    219    145 --:--:-- --:--:-- --:--:--   366\n')
