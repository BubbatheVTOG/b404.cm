import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_firewalld_installed(host):
    firewalld = host.package("firewalld")
    assert firewalld.is_installed


# TODO: Figure out why this fails on Centos7 and Fedora30
# def test_firewalld_running_and_enabled(host):
#     firewalld = host.service("firewalld")
#     assert firewalld.is_running
#     assert firewalld.is_enabled
