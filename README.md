# rancher-ebs

Simple base container for rancher sidekicks whose responsibility is to mount shared EBS volumes.

##### This container assumes it is running on an EC2 instance and will not work properly if this is not the case.

## Getting Started

#### mount an ebs volume

Run this container with the following environment variables set, and on startup it will find a free device and create/attach your volume. Newly created volumes will be formatted with the `xfs` filesystem. If the specified volume is already attached to a different instance, it will be forcibly detached and attached to this instance.

> The general use-case that this feature is designed for is the ability to specify an EBS volume that 'follows' a service container across hosts. In it's current form, it's really only intended to be used with a service of `scale: 1` (because all instances will attempt to take control of the volume named `$EBS_VOLUME_NAME` and this will not end well if they are on different hosts or aren't supposed to share data). In the future I may consider an implementation that can handle scaling services by including the service index in the volume name.

Environment Variable | Default | Role
--- | :---: | ---
`EBS_VOLUME_NAME` | `-` | Look for an EBS volume with this name in the current AZ. If it doesn't exist, create it. Then attaches this volume to an available device if not already attached. If not set, no volume will be mounted.
`EBS_VOLUME_DIR` | `/ebs/${EBS_VOLUME_NAME}` | Where to mount the volume
`EBS_VOLUME_SIZE` | `-` | If the named volume doesn't exist, it will be created with this size, otherwise this is ignored. Must be in `<size>G` format (e.g. 50G).
`EBS_VOLUME_TYPE` | `gp2` | If the named volume doesn't exist, it will be created with this type, otherwise ignored.
`EBS_VOLUME_IOPS` | `-` | If specified and the named volume doesn't exist, it will be provisioned with the specified IOPS. Otherwise ignored.

## Future Improvements

- [ ] Independent volumes for services with scale > 1
- [ ] Restore EBS from snapshot in `EBS_SNAPSHOT_ID`
- [ ] Resize EBS by updating `EBS_VOLUME_SIZE`
- [ ] Migrate volume from a different AZ
- [ ] Add EBS snapshotting scripts
