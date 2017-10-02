pragma solidity ^0.4.16;

/**
  @title Indexed Address Iterator Interactive
  @author DigixGlobal Pte Ltd
*/
contract IndexedAddressIteratorInteractive {

  /**
    @notice Lists indexed Addresses in reverse starting from the end of the list
    @param _collection_index Index of the Collection to evaluate
    @param _count The total number of Addresses to return
    @param _function_total Function that returns that Total number of addresses in the list
    @param _function_last Function that returns the last Item in the Collection
    @param _function_previous Function that returns the previous Item in the collection
    @return {"_address_items" : "Lisf of addresses in reverse"}
  */
  function list_indexed_addresses_backwards_from_end(bytes32 _collection_index, uint256 _count,
                                             function (bytes32) external constant returns (uint256) _function_total,
                                             function (bytes32) external constant returns (address) _function_last,
                                             function (bytes32, address) external constant returns (address) _function_previous)

           internal
           constant
           returns (address[] _address_items)
  {
    _address_items = list_indexed_addresses_from_start(_collection_index, _count, _function_total, _function_last, _function_previous);
  }

  /**
    @notice Lists indexed Address from start of the list
    @param _collection_index Index of the Collection to evaluate
    @param _count The total number of Addresses to return
    @param _function_total Function that returns that Total number of addresses in the list
    @param _function_first Function that returns the first Item in the Collection
    @param _function_next Function that returns the next Item in the collection
    @return {"_address_items" : "Lisf of addresses"}
  */
  function list_indexed_addresses_from_start(bytes32 _collection_index, uint256 _count,
                                             function (bytes32) external constant returns (uint256) _function_total,
                                             function (bytes32) external constant returns (address) _function_first,
                                             function (bytes32, address) external constant returns (address) _function_next)


           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    address _current_item;
    uint256 _real_count = _function_total(_collection_index);

    if (_count > _real_count) {
      _count = _real_count;
    }

    address[] memory _items_tmp = new address[](_count);

    if (_count > 0) {
      _current_item = _function_first(_collection_index);
      _items_tmp[0] = _current_item;

      for(_i = 1;_i <= (_count - 1);_i++) {
        _current_item = _function_next(_collection_index, _current_item);
        if (_current_item != address(0x0)) {
          _items_tmp[_i] = _current_item;
        }
      }
      _address_items = _items_tmp;
    } else {
      _address_items = new address[](0);
    }
  }

  /**
    @notice Lists indexed Addresses in reverse starting from the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item  The current item from the collection
    @param _count The total number of Addresses to return
    @param _function_first Function that returns the first Item in the Collection
    @param _function_previous Function that returns the previous Item in the collection
    @return {"_address_items" : "Lisf of addresses in reverse"}
  */
  function list_indexed_addresses_backwards_from_address(bytes32 _collection_index, address _current_item, uint256 _count,
                                 function (bytes32) external constant returns (address) _function_first,
                                 function (bytes32, address) external constant returns (address) _function_previous)
           internal
           constant
           returns (address[] _address_items)
  {
    _address_items = list_indexed_addresses_from_address(_collection_index, _current_item, _count, _function_first, _function_previous);
  }

  /**
    @notice Lists indexed Addresses starting from the specified `_current_item`
    @param _collection_index Index of the Collection to evaluate
    @param _current_item The current item from the collection
    @param _count The total number of Addresses to return
    @param _function_last The Function that returns the last Item in the Collection
    @param _function_next The Function that returns the next Item in the collection
    @return {"_address_items" : "Lisf of addresses"}
  */
  function list_indexed_addresses_from_address(bytes32 _collection_index, address _current_item, uint256 _count,
                                 function (bytes32) external constant returns (address) _function_last,
                                 function (bytes32, address) external constant returns (address) _function_next)
           internal
           constant
           returns (address[] _address_items)
  {
    uint256 _i;
    uint256 _real_count = 0;
    
    if (_count == 0) {
      _address_items = new address[](0);
    } else {
      address[] memory _items_temp = new address[](_count);

      address _start_item;
      address _last_item;

      _last_item = _function_last(_collection_index);

      if (_last_item != _current_item) {
        _start_item = _function_next(_collection_index, _current_item);
        if (_start_item != address(0x0)) {
          _items_temp[0] = _start_item;
          _real_count = 1;
          for(_i = 1;(_i <= (_count - 1)) && (_start_item != _last_item);_i++) {
            _start_item = _function_next(_collection_index, _start_item);
            if (_start_item != address(0x0)) {
              _real_count++;
              _items_temp[_i] = _start_item;
            }
          }
          _address_items = new address[](_real_count);
          for(_i = 0;_i <= (_real_count - 1);_i++) {
            _address_items[_i] = _items_temp[_i];
          }
        } else {
          _address_items = new address[](0);
        }
      } else {
        _address_items = new address[](0);
      }
    }

  }

}
