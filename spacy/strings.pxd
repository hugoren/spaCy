from cymem.cymem cimport Pool
from preshed.maps cimport PreshMap
from murmurhash.mrmr cimport hash64
from .typedefs cimport attr_t

from libc.stdint cimport int64_t

from .typedefs cimport hash_t

DEF UINT64_MAX = 18446744073709551615

cpdef hash_t hash_string(unicode string) except 0


ctypedef union Utf8Str:
    unsigned char[8] s
    unsigned char* p


cdef class StringStore:
    cdef Pool mem
    cdef Utf8Str* c
    cdef int64_t size

    cdef public PreshMap _map
    cdef int64_t _resize_at
    cdef PreshMap oov_maps

    cpdef int remove_oov_map(self, Pool mem) except -1

    cdef hash_t intern(self, unicode py_string, Pool mem=*) except UINT64_MAX
    cdef const Utf8Str* _intern_utf8(self, const unsigned char* utf8_string,
                                     int length) except NULL
