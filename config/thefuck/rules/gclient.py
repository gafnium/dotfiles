def match(command):
    return ("please run 'gclient sync'" in command.output.lower())

def get_new_command(command):
    return '{}'.format(command.script)

def side_effect(command, fixed_command):
    subprocess.call('gclient sync', shell=True)
    
# Optional:
enabled_by_default = True
priority = 1000  # Lower first, default is 1000
requires_output = True