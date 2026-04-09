def convert_minutes(minutes):
    hours = minutes // 60
    remaining_minutes = minutes % 60
    if hours == 0:
        return f"{remaining_minutes} minutes"
    elif remaining_minutes == 0:
        return f"{hours} hrs"
    else:
        return f"{hours} hrs {remaining_minutes} minutes"

print(convert_minutes(130))
print(convert_minutes(110))
print(convert_minutes(60))
print(convert_minutes(45))