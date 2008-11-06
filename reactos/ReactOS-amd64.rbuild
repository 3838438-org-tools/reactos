<?xml version="1.0"?>
<!DOCTYPE project SYSTEM "tools/rbuild/project.dtd">
<project name="ReactOS" makefile="makefile-amd64.auto" xmlns:xi="http://www.w3.org/2001/XInclude">
	<xi:include href="config-amd64.rbuild">
		<xi:fallback>
			<xi:include href="config-amd64.template.rbuild" />
		</xi:fallback>
	</xi:include>

	<define name="_M_AMD64" />
	<define name="_AMD64_" />
	<define name="_M_AXP64" />
	<define name="__x86_64__" />
	<define name="_X86AMD64_" />
	<define name="_WIN64" />
	<define name="TARGET_amd64" host="true" />

	<property name="PLATFORM" value="PC"/>
	<property name="usewrc" value="false"/>
	<property name="WINEBUILD_FLAGS" value="--kill-at"/>
	<property name="NTOSKRNL_SHARED" value="-shared"/>
	<linkerflag>-enable-stdcall-fixup</linkerflag>
	<compilerflag>-U_X86_</compilerflag>

	<if property="OPTIMIZE" value="1">
		<compilerflag>-Os</compilerflag>
		<compilerflag>-ftracer</compilerflag>
		<compilerflag>-momit-leaf-frame-pointer</compilerflag>
	</if>
	<if property="OPTIMIZE" value="2">
		<compilerflag>-Os</compilerflag>
	</if>
	<if property="OPTIMIZE" value="3">
		<compilerflag>-O1</compilerflag>
	</if>
	<if property="OPTIMIZE" value="4">
		<compilerflag>-O2</compilerflag>
	</if>
	<if property="OPTIMIZE" value="5">
		<compilerflag>-O3</compilerflag>
	</if>

	<compilerflag>-mpreferred-stack-boundary=4</compilerflag>
	<compilerflag>-fno-strict-aliasing</compilerflag>
	<compilerflag>-Wno-strict-aliasing</compilerflag>
	<compilerflag>-Wpointer-arith</compilerflag>
	<compilerflag>-Wno-uninitialized</compilerflag>
	<linkerflag>-enable-stdcall-fixup</linkerflag>
	<linkerflag>-static</linkerflag>

<!-- Here starts <xi:include href="ReactOS-generic.rbuild" /> -->

	<xi:include href="baseaddress.rbuild" />

	<define name="__REACTOS__" />
	<if property="DBG" value="1">
		<define name="DBG">1</define>
		<define name="_SEH_ENABLE_TRACE" />
		<property name="DBG_OR_KDBG" value="true" />
	</if>
	<if property="KDBG" value="1">
		<define name="KDBG">1</define>
		<property name="DBG_OR_KDBG" value="true" />
	</if>

	<!-- The version target valid values are: Nt4 , NT5 , NT51 -->
	<property name="VERSION_TARGET" value="NT52" />

	<if property="VERSION_TARGET" value="NT4">
		<define name="WINVER" overridable="true">0x400</define>
		<define name="_WIN32_IE">0x600</define>
		<define name="_WIN32_WINNT" overridable="true">0x400</define>
		<define name="_WIN32_WINDOWS">0x400</define>
		<define name="_SETUPAPI_VER">0x400</define>
	</if>

	<if property="VERSION_TARGET" value="NT5">
		<define name="WINVER" overridable="true">0x500</define>
		<define name="_WIN32_IE">0x600</define>
		<define name="_WIN32_WINNT" overridable="true">0x500</define>
		<define name="_WIN32_WINDOWS">0x500</define>
		<define name="_SETUPAPI_VER">0x500</define>
	</if>

	<if property="VERSION_TARGET" value="NT51">
		<define name="WINVER" overridable="true">0x501</define>
		<define name="_WIN32_IE">0x600</define>
		<define name="_WIN32_WINNT" overridable="true">0x501</define>
		<define name="_WIN32_WINDOWS">0x501</define>
		<define name="_SETUPAPI_VER">0x501</define>
	</if>

	<if property="VERSION_TARGET" value="NT52">
		<define name="WINVER" overridable="true">0x502</define>
		<define name="_WIN32_IE">0x600</define>
		<define name="_WIN32_WINNT" overridable="true">0x502</define>
		<define name="_WIN32_WINDOWS">0x502</define>
		<define name="_SETUPAPI_VER">0x502</define>
	</if>

	<if property="VERSION_TARGET" value="NT6">
		<define name="WINVER" overridable="true">0x600</define>
		<define name="_WIN32_IE">0x600</define>
		<define name="_WIN32_WINNT" overridable="true">0x600</define>
		<define name="_WIN32_WINDOWS">0x600</define>
		<define name="_SETUPAPI_VER">0x600</define>
	</if>

	<include>.</include>
	<include>include</include>
	<include root="intermediate">include</include>
	<include>include/psdk</include>
	<include root="intermediate">include/psdk</include>
	<include>include/dxsdk</include>
	<include root="intermediate">include/dxsdk</include>
	<include>include/crt</include>
	<include>include/crt/mingw32</include>
	<include>include/ddk</include>
	<include>include/GL</include>
	<include>include/ndk</include>
	<include>include/reactos</include>
	<include root="intermediate">include/reactos</include>
	<include root="intermediate">include/reactos/mc</include>
	<include>include/reactos/libs</include>

	<include host="true">include</include>
	<include host="true" root="intermediate">include</include>
	<include host="true">include/reactos</include>
	<include host="true">include/reactos/wine</include>

	<!-- directory name="base">
		<xi:include href="base/base.rbuild" />
	</directory -->

	<directory name="boot">
		<xi:include href="boot/boot.rbuild" />
	</directory>

	<!-- directory name="dll">
		<xi:include href="dll/dll.rbuild" />
	</directory -->

	<directory name="drivers">
		<directory name="base">
			<xi:include href="drivers/base/directory.rbuild" />
		</directory>
		<directory name="filesystems">
			<directory name="cdfs">
				<xi:include href="drivers/filesystems/cdfs/cdfs.rbuild" />
			</directory>
			<directory name="fastfat">
				<xi:include href="drivers/filesystems/fastfat/vfatfs.rbuild" />
			</directory>
			<directory name="ext2">
				<!-- xi:include href="drivers/filesystems/ext2/ext2.rbuild" / -->
			</directory>
		</directory>
		<directory name="input">
			<xi:include href="drivers/input/directory.rbuild" />
		</directory>
		<directory name="network">
			<directory name="ndis">
				<xi:include href="drivers/network/ndis/ndis.rbuild" />
			</directory>
			<directory name="tcpip">
				<xi:include href="drivers/network/tcpip/tcpip.rbuild" />
			</directory>
		</directory>
		<directory name="setup">
			<xi:include href="drivers/setup/directory.rbuild" />
		</directory>
		<directory name="storage">
			<directory name="class">
				<directory name="cdrom">
					<xi:include href="drivers/storage/class/cdrom/cdrom.rbuild" />
				</directory>
				<directory name="class2">
					<xi:include href="drivers/storage/class/class2/class2.rbuild" />
				</directory>
				<directory name="disk">
					<xi:include href="drivers/storage/class/disk/disk.rbuild" />
				</directory>
			</directory>
			<directory name="floppy">
				<xi:include href="drivers/storage/floppy/floppy.rbuild" />
			</directory>
			<directory name="ide">
				<directory name="atapi">
					<xi:include href="drivers/storage/ide/atapi/atapi.rbuild" />
				</directory>
			</directory>
			<directory name="port">
				<xi:include href="drivers/storage/port/directory.rbuild" />
			</directory>
			<directory name="scsiport">
				<xi:include href="drivers/storage/scsiport/scsiport.rbuild" />
			</directory>
		</directory>
	</directory>

	<directory name="hal">
		<xi:include href="hal/hal.rbuild" />
	</directory>

	<directory name="include">
		<xi:include href="include/directory.rbuild" />
	</directory>
	<directory name="lib">
		<xi:include href="lib/lib.rbuild" />
	</directory>

	<directory name="media">
		<xi:include href="media/media.rbuild" />
	</directory>

	<directory name="ntoskrnl">
		<xi:include href="ntoskrnl/ntoskrnl-amd64hack.rbuild" />
	</directory>

	<!-- directory name="subsystems">
		<xi:include href="subsystems/subsystems.rbuild" />
	</directory -->

	<directory name="tools">
		<xi:include href="tools/tools.rbuild" />
	</directory>

<!-- Here ends <xi:include href="ReactOS-generic.rbuild" /> -->

</project>
