/*
 * Copyright (C) 2008, The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.bluetooth;

import android.bluetooth.IBluetoothCallback;
import android.bluetooth.IBluetoothStateChangeCallback;
import android.bluetooth.BluetoothActivityEnergyInfo;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.OobData;
import android.os.ParcelUuid;
import android.os.ParcelFileDescriptor;

/**
 * System private API for talking with the Bluetooth service.
 *
 * {@hide}
 */
interface IBluetooth
{
    boolean isEnabled();
    int getState();
    boolean enable();
    boolean enableNoAutoConnect();
    boolean disable();

    String getAddress();
    ParcelUuid[] getUuids();
    boolean setName(in String name);
    String getName();

    int getScanMode();
    boolean setScanMode(int mode, int duration);

    int getDiscoverableTimeout();
    boolean setDiscoverableTimeout(int timeout);

    boolean startDiscovery();
    boolean cancelDiscovery();
    boolean isDiscovering();

    int getAdapterConnectionState();
    int getProfileConnectionState(int profile);

    BluetoothDevice[] getBondedDevices();
    boolean createBond(in BluetoothDevice device, in int transport);
    boolean createBondOutOfBand(in BluetoothDevice device, in int transport, in OobData oobData);
    boolean cancelBondProcess(in BluetoothDevice device);
    boolean removeBond(in BluetoothDevice device);
    int getBondState(in BluetoothDevice device);
    int getConnectionState(in BluetoothDevice device);

    String getRemoteName(in BluetoothDevice device);
    int getRemoteType(in BluetoothDevice device);
    String getRemoteAlias(in BluetoothDevice device);
    boolean setRemoteAlias(in BluetoothDevice device, in String name);
    int getRemoteClass(in BluetoothDevice device);
    ParcelUuid[] getRemoteUuids(in BluetoothDevice device);
    boolean fetchRemoteUuids(in BluetoothDevice device);
    boolean sdpSearch(in BluetoothDevice device, in ParcelUuid uuid);

    int createMapMnsSdpRecord(in String serviceName, in int rfcommChannel,
            in int l2capPsm, in int version, in int features);
    int createPbapPceSdpRecord(in String serviceName, in int version);
    boolean removeSdpRecord(in int recordHandle);

    boolean setPin(in BluetoothDevice device, boolean accept, int len, in byte[] pinCode);
    boolean setPasskey(in BluetoothDevice device, boolean accept, int len, in byte[]
    passkey);
    boolean setPairingConfirmation(in BluetoothDevice device, boolean accept);

    int getPhonebookAccessPermission(in BluetoothDevice device);
    boolean setPhonebookAccessPermission(in BluetoothDevice device, int value);
    int getMessageAccessPermission(in BluetoothDevice device);
    boolean setMessageAccessPermission(in BluetoothDevice device, int value);
    int getSimAccessPermission(in BluetoothDevice device);
    boolean setSimAccessPermission(in BluetoothDevice device, int value);

    void sendConnectionStateChange(in BluetoothDevice device, int profile, int state, int prevState);

    void registerCallback(in IBluetoothCallback callback);
    void unregisterCallback(in IBluetoothCallback callback);

    // For Socket
    ParcelFileDescriptor connectSocket(in BluetoothDevice device, int type, in ParcelUuid uuid, int port, int flag);
    ParcelFileDescriptor createSocketChannel(int type, in String serviceName, in ParcelUuid uuid, int port, int flag);

    boolean configHciSnoopLog(boolean enable);
    boolean factoryReset();

    boolean isMultiAdvertisementSupported();
    boolean isPeripheralModeSupported();
    boolean isOffloadedFilteringSupported();
    boolean isOffloadedScanBatchingSupported();
    boolean isActivityAndEnergyReportingSupported();
    void getActivityEnergyInfoFromController();
    BluetoothActivityEnergyInfo reportActivityInfo();

    void onLeServiceUp();
    void onBrEdrDown();

    int setSocketOpt(int type, int port, int optionName, in byte [] optionVal, int optionLen);
    int getSocketOpt(int type, int port, int optionName, out byte [] optionVal);
}
