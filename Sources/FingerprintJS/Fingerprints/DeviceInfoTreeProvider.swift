//
//  DeviceInfoTreeProvider.swift
//  FingerprintJS
//
//  Created by Petr Palata on 20.03.2022.
//

import Foundation

protocol DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem
}

extension HardwareInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Hardware",
            value: .category,
            children: itemsForVersion(configuration.version)
        )
    }

    private func itemsForVersion(_ version: FingerprintJSVersion) -> [DeviceInfoItem] {
        switch version {
        case .v1:
            return [
                DeviceInfoItem(label: "Device type", value: .info(deviceType)),
                DeviceInfoItem(label: "Device model", value: .info(deviceModel)),
                DeviceInfoItem(label: "Display resolution", value: .info(self.displayResolution.description)),
                DeviceInfoItem(label: "Physical memory", value: .info(memorySize)),
                DeviceInfoItem(label: "Processor count", value: .info(cpuCount)),
            ]
        case .v2:
            return [
                DeviceInfoItem(label: "Device type", value: .info(deviceType)),
                DeviceInfoItem(label: "Device model", value: .info(deviceModel)),
                DeviceInfoItem(label: "Display resolution", value: .info(self.displayResolution.description)),
                DeviceInfoItem(label: "Physical memory", value: .info(memorySize)),
                DeviceInfoItem(label: "Processor count", value: .info(cpuCount)),
                DeviceInfoItem(label: "Free disk space (B)", value: .info(String(describing: freeDiskSpace))),
                DeviceInfoItem(label: "Total disk space (B)", value: .info(String(describing: totalDiskSpace))),
            ]
        }
    }
}

extension IdentifierHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Identifiers",
            value: .category,
            children: [
                DeviceInfoItem(
                    label: "Vendor identifier",
                    value: .info(vendorIdentifier?.uuidString ?? "No identifier")
                )
            ]
        )
    }
}

extension OSInfoHarvester: DeviceInfoTreeProvider {
    func buildTree(_ configuration: Configuration) -> DeviceInfoItem {
        return DeviceInfoItem(
            label: "Operating System",
            value: .category,
            children: [
                // DeviceInfoItem(label: "OS build", value: .info(osBuild)),
                DeviceInfoItem(label: "OS release", value: .info(osRelease)),
                DeviceInfoItem(label: "OS type", value: .info(osType)),
                DeviceInfoItem(label: "OS version", value: .info(osVersion)),
                DeviceInfoItem(label: "Kernel version", value: .info(kernelVersion)),
            ]
        )
    }
}
