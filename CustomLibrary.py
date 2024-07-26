
from robot.api.logger import info, debug, trace, console

class CustomLibrary:

    ROBOT_LIBRARY_SCOPE = 'SUITE'

    def __init__(self) -> None:
        return None

    def value_is_lower_than(self, site_value, expected_max):
        '''Verifies that the value shown on site is lower than the max value.'''
        clean_value = site_value.strip('Cost:\n£')
        clean_value = clean_value.replace(',','')
        clean_value = float(clean_value)
        expected_max = float(expected_max)
        assert clean_value < expected_max, f'{site_value} is not lower than {expected_max}'
        info(f'Value: {site_value} is lower than Value: {expected_max}')
