// generated from rosidl_typesupport_microxrcedds_c/resource/idl__rosidl_typesupport_c.h.em
// with input from @(package_name):@(interface_path)
// generated code does not contain a copyright notice
@
@#######################################################################
@# EmPy template for generating <idl>__rosidl_typesupport_microxrcedds_c.h files
@#
@# Context:
@#  - package_name (string)
@#  - interface_path (Path relative to the directory named after the package)
@#  - content (IdlContent, list of elements, e.g. Messages or Services)
@#######################################################################
@
@{
from rosidl_cmake import convert_camel_case_to_lower_case_underscore
include_parts = [package_name] + list(interface_path.parents[0].parts) + \
    [convert_camel_case_to_lower_case_underscore(interface_path.stem)]
header_guard_variable = '__'.join([x.upper() for x in include_parts]) + \
    '__ROSIDL_TYPESUPPORT_MICROXRCEDDS_C_H_'
}@
#ifndef @(header_guard_variable)
#define @(header_guard_variable)

@{
include_directives = set()
}@
@#######################################################################
@# Handle message
@####################################################################
@{
from rosidl_parser.definition import Message
}@
@[for message in content.get_elements_of_type(Message)]@

@{
TEMPLATE(
    'msg__rosidl_typesupport_microxrcedds_c.h.em',
    package_name=package_name,
    interface_path=interface_path,
    message=message,
    include_directives=include_directives)
}@
@[end for]@

#endif // @(header_guard_variable)