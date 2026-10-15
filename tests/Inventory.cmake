include("${CMAKE_CURRENT_LIST_DIR}/ApfsUtilTest.cmake")

run(0 valid.img)
contains("${output}" "42 : 'test-snapshot'")

foreach(name bad-snapshots missing-snapshots bad-first-snapshot bad-later-snapshot bad-snapshot-name
	snapshot-short-key snapshot-short-value snapshot-missing-value snapshot-empty-name snapshot-unterminated-name)
	run(3 "${name}.img")
	contains("${errors}" "Volume 0: snapshot metadata unavailable or unreadable")
	contains("${output}" "Name: +System")
endforeach()
run(3 bad-later-snapshot.img)
contains("${output}" "42 : 'test-snapshot'")
run(0 branched.img)
contains("${output}" "43 : 'test-snapshot'")
run(0 empty-snapshots.img)
message(STATUS "APFS inventory tests passed")
