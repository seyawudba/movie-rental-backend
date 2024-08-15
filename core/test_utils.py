# from django.test import TestCase

# Create your tests here.
import pytest


@pytest.mark.django_db
class TestSample:
    def test_sample_code_for_set_up(self, test_sample):
        value = test_sample
        assert 5 == value
